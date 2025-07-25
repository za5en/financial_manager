import 'package:financial_manager/data/enums/change_type.dart';
import 'package:financial_manager/data/methods/account_methods.dart';
import 'package:financial_manager/data/models/account/account_create_request_model.dart';
import 'package:financial_manager/data/models/account/account_history_model.dart';
import 'package:financial_manager/data/models/account/account_history_response_model.dart';
import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/account/account_response_model.dart';
import 'package:financial_manager/data/models/account/account_state_model.dart';
import 'package:financial_manager/data/models/account/account_update_request_model.dart';
import 'package:financial_manager/data/models/stats/stat_item_model.dart';
import 'package:financial_manager/data/repos/bank_account_repo_data.dart';
import 'package:financial_manager/domain/repos/bank_account_repo_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountApi extends Mock implements AccountMethods {}

void main() async {
  MockAccountApi accountApiMock = MockAccountApi();
  BankAccountRepoDomain accountRepository = BankAccountRepoData(accountApiMock);
  WidgetsFlutterBinding.ensureInitialized();
  const expectedId = 1;
  const unexpectedId = -1;

  final expectedAccountCreateRequestModel = AccountCreateRequestModel(
    name: 'test',
    balance: '125',
    currency: 'RUB',
  );

  const unexpectedAccountCreateRequestModel = AccountCreateRequestModel(
    name: '',
    balance: '',
    currency: '123',
  );

  final expectedAccountUpdateRequestModel = AccountUpdateRequestModel(
    name: 'test1',
    balance: '250',
    currency: 'USD',
  );

  const unexpectedAccountUpdateRequestModel = AccountUpdateRequestModel(
    name: '',
    balance: '',
    currency: '123',
  );

  final expectedAccountModel = AccountModel(
    id: 1,
    userId: 1,
    name: 'test',
    balance: '125',
    currency: 'RUB',
    createdAt: '2025-07-25T10:10:10',
    updatedAt: '2025-07-25T10:10:10',
  );

  final expectedAccountResponseModel = AccountResponseModel(
    id: 1,
    name: 'test',
    balance: '125',
    currency: 'RUB',
    incomeStats: [
      StatItemModel(
        categoryId: 1,
        categoryName: 'income',
        emoji: 'emoji',
        amount: '1',
      ),
    ],
    expenseStats: [
      StatItemModel(
        categoryId: 2,
        categoryName: 'expense',
        emoji: 'emoji',
        amount: '1',
      ),
    ],
    createdAt: '2025-07-25T10:10:10',
    updatedAt: '2025-07-25T10:10:10',
  );

  final expectedAccountsList = [
    AccountModel(
      id: 1,
      userId: 1,
      name: 'test',
      balance: '125',
      currency: 'RUB',
      createdAt: 'createdAt',
      updatedAt: 'updatedAt',
    ),
  ];

  final expectedAccountHistory = AccountHistoryResponseModel(
    accountId: 1,
    accountName: 'test',
    currency: 'RUB',
    currentBalance: '125',
    history: [
      AccountHistoryModel(
        id: 1,
        accountId: 1,
        changeType: ChangeType.modification,
        newState: AccountStateModel(
          id: 1,
          name: 'test',
          balance: '125',
          currency: 'RUB',
        ),
        changeTimestamp: '2025-07-25T10:10:10',
        createdAt: '2025-07-25T10:10:10',
      ),
    ],
  );

  setUp(() {
    accountApiMock = MockAccountApi();
    when(
      () => accountApiMock.createAccount(expectedAccountCreateRequestModel),
    ).thenAnswer((_) async => expectedAccountModel);

    when(
      () => accountApiMock.createAccount(unexpectedAccountCreateRequestModel),
    ).thenThrow(Exception());

    when(
      () => accountApiMock.getAccount(),
    ).thenAnswer((_) async => expectedAccountsList);

    when(
      () => accountApiMock.getAccountById(expectedId),
    ).thenAnswer((_) async => expectedAccountResponseModel);

    when(
      () => accountApiMock.getAccountById(unexpectedId),
    ).thenThrow(Exception());

    when(
      () => accountApiMock.updateAccount(
        expectedId,
        expectedAccountUpdateRequestModel,
      ),
    ).thenAnswer((_) async => expectedAccountModel);

    when(
      () => accountApiMock.updateAccount(
        unexpectedId,
        expectedAccountUpdateRequestModel,
      ),
    ).thenThrow(Exception());

    when(
      () => accountApiMock.updateAccount(
        expectedId,
        unexpectedAccountUpdateRequestModel,
      ),
    ).thenThrow(Exception());

    when(
      () => accountApiMock.getAccountHistory(expectedId),
    ).thenAnswer((_) async => expectedAccountHistory);

    when(
      () => accountApiMock.getAccountHistory(unexpectedId),
    ).thenThrow(Exception());

    when(
      () => accountApiMock.deleteAccount(any()),
    ).thenAnswer((_) => Future(() {}));

    accountRepository = BankAccountRepoData(accountApiMock);
  });

  group('В классе BankAccountRepoData', () {
    group('Метод createAccount', () {
      test(
        'должен корректно создать счёт и вернуть модель счёта AccountModel с указанными в AccountCreateRequestModel параметрами и id > 0',
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          const expectedAccountCreateRequestModel = AccountCreateRequestModel(
            name: 'test',
            balance: '125',
            currency: 'RUB',
          );

          await accountRepository.createAccount(
            expectedAccountCreateRequestModel,
          );

          verify(
            () =>
                accountApiMock.createAccount(expectedAccountCreateRequestModel),
          );
        },
      );
      test(
        'должен бросить исключение, если модель AccountCreateRequestModel некорректная',
        () async {
          await expectLater(
            accountRepository.createAccount(
              unexpectedAccountCreateRequestModel,
            ),
            throwsA(isA<Exception>()),
          );

          verifyNever(
            () => accountApiMock.createAccount(
              unexpectedAccountCreateRequestModel,
            ),
          );
        },
      );
    });

    group('Метод getAccount', () {
      test('должен вернуть список корректных моделей AccountModel', () async {
        await accountRepository.getAccount();

        verify(() => accountApiMock.getAccount());
      });
    });

    group('Метод getAccountById', () {
      test(
        'должен вернуть корректную модель AccountModel, если указан id существующего счёта',
        () async {
          await accountRepository.getAccountById(expectedId);

          verify(() => accountApiMock.getAccountById(expectedId));
        },
      );
      test(
        'должен бросить исключение, если указан id несуществующего счёта',
        () async {
          await expectLater(
            accountRepository.getAccountById(unexpectedId),
            throwsA(isA<Exception>()),
          );

          verifyNever(() => accountApiMock.getAccountById(unexpectedId));
        },
      );
    });

    group('Метод getAccountHistory', () {
      test(
        'должен вернуть корректную модель AccountHistoryModel, если указан id существующего счёта',
        () async {
          await accountRepository.getAccountHistory(expectedId);

          verify(() => accountApiMock.getAccountHistory(expectedId));
        },
      );
      test(
        'должен бросить исключение, если указан id несуществующего счёта',
        () async {
          await expectLater(
            accountRepository.getAccountHistory(unexpectedId),
            throwsA(isA<Exception>()),
          );

          verifyNever(() => accountApiMock.getAccountHistory(unexpectedId));
        },
      );
    });

    group('Метод updateAccount', () {
      test(
        'должен вернуть обновлённую модель счёта AccountModel с указанными в AccountUpdateRequestModel параметрами',
        () async {
          await accountRepository.updateAccount(
            expectedId,
            expectedAccountUpdateRequestModel,
          );

          verify(
            () => accountApiMock.updateAccount(
              expectedId,
              expectedAccountUpdateRequestModel,
            ),
          );
        },
      );
      test(
        'должен бросить исключение, если указан id несуществующего счёта',
        () async {
          await expectLater(
            accountRepository.updateAccount(
              unexpectedId,
              expectedAccountUpdateRequestModel,
            ),
            throwsA(isA<Exception>()),
          );

          verifyNever(
            () => accountApiMock.updateAccount(
              unexpectedId,
              expectedAccountUpdateRequestModel,
            ),
          );
        },
      );
      test(
        'должен бросить исключение, если модель AccountUpdateRequestModel некорректная',
        () async {
          await expectLater(
            accountRepository.updateAccount(
              expectedId,
              unexpectedAccountUpdateRequestModel,
            ),
            throwsA(isA<Exception>()),
          );

          verifyNever(
            () => accountApiMock.updateAccount(
              expectedId,
              unexpectedAccountUpdateRequestModel,
            ),
          );
        },
      );
    });

    group('Метод deleteAccount', () {
      test(
        'должен успешно отработать, если указан id существующего счёта',
        () async {
          await accountRepository.deleteAccount(expectedId);

          verify(() => accountApiMock.deleteAccount(expectedId));
        },
      );
      test(
        'должен бросить исключение, если указан id несуществующего счёта',
        () async {
          await expectLater(
            accountRepository.deleteAccount(unexpectedId),
            throwsA(isA<Exception>()),
          );

          verifyNever(() => accountApiMock.deleteAccount(unexpectedId));
        },
      );
    });
  });
}

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift_database.g.dart';

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get name => text()();
  TextColumn get balance => text()();
  TextColumn get currency => text()();
  TextColumn get createdAt => text()(); // date-time
  TextColumn get updatedAt => text()(); // date-time
  TextColumn get changeType => text()(); // CREATION, MODIFICATION
}

class AccountState extends Table {
  IntColumn get id => integer().references(Account, #id)();
  TextColumn get name => text()();
  TextColumn get balance => text()();
  TextColumn get currency => text()();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId => integer().references(Account, #id)();
  IntColumn get categoryId => integer().references(Category, #id)();
  TextColumn get amount => text()();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get comment => text().nullable()();
  TextColumn get createdAt => text()(); // date-time
  TextColumn get updatedAt => text()(); // date-time
}

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get emoji => text()();
  BoolColumn get isIncome => boolean()();
}

class StatItem extends Table {
  IntColumn get categoryId => integer().references(Category, #id)();
  TextColumn get categoryName => text()();
  TextColumn get emoji => text()();
  TextColumn get amount => text()();
}

@DriftDatabase(
  tables: [Account, AccountState, Transactions, Category, StatItem],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // await _createIndexes();
      },
    );
  }

  // Future<void> _createIndexes() async {
  //   await customStatement('''
  //     CREATE INDEX IF NOT EXISTS idx_account_user_id
  //     ON account(user_id);
  //   ''');

  //   await customStatement('''
  //     CREATE INDEX IF NOT EXISTS idx_account_change_type
  //     ON account(change_type);
  //   ''');

  //   await customStatement('''
  //     CREATE INDEX IF NOT EXISTS idx_transaction_transaction_date
  //     ON transaction(transaction_date);
  //   ''');

  //   await customStatement('''
  //     CREATE INDEX IF NOT EXISTS idx_transaction_amount
  //     ON transaction(amount);
  //   ''');

  //   await customStatement('''
  //     CREATE INDEX IF NOT EXISTS idx_category_name
  //     ON category(name);
  //   ''');
  // }

  // CRUD для аккаунта
  Future<AccountData> createAccount(
    int userId,
    String name,
    String balance,
    String currency,
    String createdAt,
    String updatedAt,
    String changeType,
  ) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        userId: userId,
        name: name,
        balance: balance,
        currency: currency,
        createdAt: createdAt,
        updatedAt: updatedAt,
        changeType: changeType,
      ),
    );
    return (select(account)
      ..where((t) => (t.userId.equals(userId)))).getSingle();
  }

  Future<List<AccountData>> getAccount() async {
    return (select(account)).get();
  }

  Future<AccountData> getAccountById(int id) async {
    return (select(account)..where((t) => (t.id.equals(id)))).getSingle();
  }

  Future<AccountData> getAccountHistory(int id) async {
    return (select(account)..where((t) => (t.id.equals(id)))).getSingle();
  }

  Future<AccountData> updateAccount(
    int id,
    int userId,
    String name,
    String balance,
    String currency,
    String createdAt,
    String updatedAt,
    String changeType,
  ) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion(
        id: Value(id),
        userId: Value(userId),
        name: Value(name),
        balance: Value(balance),
        currency: Value(currency),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
        changeType: Value(changeType),
      ),
    );
    return (select(account)..where((t) => (t.id.equals(id)))).getSingle();
  }

  Future<List<StatItemData>> getStatItems() async {
    return (select(statItem)).get();
  }

  // CRUD для категорий
  Future<List<CategoryData>> getCategories() async {
    return (select(category)).get();
  }

  Future<CategoryData> getCategoryById(int id) async {
    return (select(category)..where((t) => (t.id.equals(id)))).getSingle();
  }

  Future<List<CategoryData>> getCategoriesByType(bool isIncome) async {
    return (select(category)
      ..where((t) => (t.isIncome.equals(isIncome)))).get();
  }

  // CRUD для транзакций
  Future<Transaction> createTransaction(
    int accountId,
    int categoryId,
    String amount,
    DateTime transactionDate,
    String createdAt,
    String updatedAt,
  ) async {
    into(transactions).insertOnConflictUpdate(
      TransactionsCompanion.insert(
        accountId: accountId,
        categoryId: categoryId,
        amount: amount,
        transactionDate: transactionDate,
        createdAt: createdAt,
        updatedAt: updatedAt,
      ),
    );
    return (select(transactions)
      ..where((t) => (t.accountId.equals(accountId)))).getSingle();
  }

  Future<void> deleteTransaction(int id) async {
    await (delete(transactions)..where((t) => t.id.equals(id))).go();
  }

  Future<Transaction> getTransactionById(int id) async {
    return (select(transactions)
      ..where((t) => (t.accountId.equals(id)))).getSingle();
  }

  Future<List<Transaction>> getTransactionsByPeriod({
    required int accountId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return (select(transactions)..where(
      (t) =>
          (t.accountId.equals(accountId)) &
          (t.transactionDate.isBetweenValues(
            startDate ?? DateTime.now().copyWith(hour: 0, minute: 0, second: 0),
            endDate ??
                DateTime.now().copyWith(hour: 23, minute: 59, second: 59),
          )),
    )).get();
  }

  Future<Transaction> updateTransaction(
    int id,
    int accountId,
    int categoryId,
    String amount,
    DateTime transactionDate,
    String createdAt,
    String updatedAt,
  ) async {
    await into(transactions).insertOnConflictUpdate(
      TransactionsCompanion(
        id: Value(id),
        accountId: Value(accountId),
        categoryId: Value(categoryId),
        amount: Value(amount),
        transactionDate: Value(transactionDate),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      ),
    );
    return (select(transactions)..where((t) => (t.id.equals(id)))).getSingle();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'financial_manager_drift.db'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get total => 'Всего';

  @override
  String get expenses => 'Расходы сегодня';

  @override
  String get expensesTab => 'Расходы';

  @override
  String get noExpenses => 'Расходов за сегодня нет';

  @override
  String get incomes => 'Доходы сегодня';

  @override
  String get incomesTab => 'Доходы';

  @override
  String get noIncomes => 'Доходов за сегодня нет';

  @override
  String get myExpenses => 'Мои расходы';

  @override
  String get myIncomes => 'Мои доходы';

  @override
  String get accountName => 'Счет';

  @override
  String get accountNoName => 'Без названия';

  @override
  String get articleName => 'Статья';

  @override
  String get date => 'Дата';

  @override
  String get time => 'Время';

  @override
  String get comment => 'Комментарий';

  @override
  String get deleteExpense => 'Удалить расход';

  @override
  String get deleteIncome => 'Удалить доход';

  @override
  String get createError => 'Ошибка создания';

  @override
  String get editError => 'Ошибка сохранения';

  @override
  String get createErrorDesc =>
      'Необходимо заполнить все обязательные поля (все кроме комментария)';

  @override
  String get cancelCreate => 'Отменить создание';

  @override
  String get cancelEdit => 'Отменить редактирование';

  @override
  String get cancelEditDesc => 'Вы действительно хотите отменить изменения?';

  @override
  String get cancel => 'Отмена';

  @override
  String get deleteExpenseDesc => 'Вы действительно хотите удалить расход?';

  @override
  String get deleteIncomeDesc => 'Вы действительно хотите удалить доход?';

  @override
  String get delete => 'Удалить';

  @override
  String get history => 'Моя история';

  @override
  String get historyStart => 'Начало';

  @override
  String get historyEnd => 'Конец';

  @override
  String get historySort => 'Сортировка';

  @override
  String get historySum => 'Сумма';

  @override
  String get sortByDate => 'По дате';

  @override
  String get sortBySum => 'По сумме';

  @override
  String get noTransactions => 'Транзакции за указанный период не найдены';

  @override
  String get analysis => 'Анализ';

  @override
  String get period => 'Период';

  @override
  String get account => 'Мой счет';

  @override
  String get accountTab => 'Счет';

  @override
  String get accountBalance => 'Баланс';

  @override
  String get deleteAccount => 'Удалить счет';

  @override
  String get currency => 'Валюта';

  @override
  String get ruble => 'Российский рубль';

  @override
  String get dollar => 'Американский доллар';

  @override
  String get euro => 'Евро';

  @override
  String get articles => 'Мои статьи';

  @override
  String get articlesTab => 'Статьи';

  @override
  String get findArticles => 'Найти статью';

  @override
  String get settings => 'Настройки';

  @override
  String get darkTheme => 'Системная тема';

  @override
  String get mainColor => 'Основной цвет';

  @override
  String get sounds => 'Звуки';

  @override
  String get haptics => 'Хаптики';

  @override
  String get passwordCode => 'Код пароль';

  @override
  String get syncronization => 'Синхронизация';

  @override
  String get language => 'Языки';

  @override
  String get about => 'О программе';

  @override
  String get select => 'Выбрать';

  @override
  String get biometrics => 'Вход по биометрии';

  @override
  String get codeToEnter => 'Введите код для входа\nв приложение';

  @override
  String get wrongCodeTryAgain => 'Введён неверный код, попробуйте ещё раз';

  @override
  String get forgotCode => 'Забыли код';

  @override
  String get warning => 'Внимание';

  @override
  String get resetCodeConfirm => 'Вы действительно хотите сбросить код пароль?';

  @override
  String get createCode => 'Создать код для входа';

  @override
  String get confirmCode => 'Подтвердите код';

  @override
  String get oldCode => 'Введите старый код';

  @override
  String get newCode => 'Введите новый код';

  @override
  String get next => 'Далее';

  @override
  String get setupCode => 'Установить код';

  @override
  String get cancelChanges => 'Отменить изменения';

  @override
  String get fourDigitCodeWarn => 'Необходимо ввести 4-х значный числовой код';

  @override
  String get codeSaved => 'Код успешно сохранён';

  @override
  String get differentCodes => 'Введённые коды не совпадают';

  @override
  String get wrongCode => 'Введён неверный код';

  @override
  String get biometricsError => 'Ошибка использования биометрии';

  @override
  String get biometricsErrorDesc =>
      'Убедитесь, что в настройках устройства установлен отпечаток пальца или распознавание лица';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get total => 'Total';

  @override
  String get expenses => 'Today\'s Expenses';

  @override
  String get expensesTab => 'Expenses';

  @override
  String get noExpenses => 'There are no expenses for today';

  @override
  String get incomes => 'Today\'s Earnings';

  @override
  String get incomesTab => 'Earnings';

  @override
  String get noIncomes => 'There are no earnings for today';

  @override
  String get myExpenses => 'My Expenses';

  @override
  String get myIncomes => 'My Earnings';

  @override
  String get accountName => 'Account';

  @override
  String get accountNoName => 'Untitled';

  @override
  String get articleName => 'Article';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get comment => 'Comment';

  @override
  String get deleteExpense => 'Delete expense';

  @override
  String get deleteIncome => 'Delete income';

  @override
  String get createError => 'Creation error';

  @override
  String get editError => 'Editing error';

  @override
  String get createErrorDesc =>
      'All required fields must be filled in (all except the comment)';

  @override
  String get cancelCreate => 'Cancel creation';

  @override
  String get cancelEdit => 'Cancel editing';

  @override
  String get cancelEditDesc => 'Do you really want to undo the changes?';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteExpenseDesc => 'Do you really want to remove the expense?';

  @override
  String get deleteIncomeDesc => 'Do you really want to delete the income?';

  @override
  String get delete => 'Delete';

  @override
  String get history => 'My History';

  @override
  String get historyStart => 'Start';

  @override
  String get historyEnd => 'End';

  @override
  String get historySort => 'Sort';

  @override
  String get historySum => 'Total amount';

  @override
  String get sortByDate => 'By date';

  @override
  String get sortBySum => 'By amount';

  @override
  String get noTransactions =>
      'No transactions were found for the specified period';

  @override
  String get analysis => 'Analysis';

  @override
  String get period => 'Period';

  @override
  String get account => 'My Account';

  @override
  String get accountTab => 'Account';

  @override
  String get accountBalance => 'Balance';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get currency => 'Currency';

  @override
  String get ruble => 'Russian ruble';

  @override
  String get dollar => 'US dollar';

  @override
  String get euro => 'Euro';

  @override
  String get articles => 'My Articles';

  @override
  String get articlesTab => 'Articles';

  @override
  String get findArticles => 'Find an article';

  @override
  String get settings => 'Settings';

  @override
  String get darkTheme => 'System theme';

  @override
  String get mainColor => 'Main color';

  @override
  String get sounds => 'Sounds';

  @override
  String get haptics => 'Haptics';

  @override
  String get passwordCode => 'Password code';

  @override
  String get syncronization => 'Synchronization';

  @override
  String get language => 'Language selection';

  @override
  String get about => 'About the app';

  @override
  String get select => 'Select';

  @override
  String get biometrics => 'Log in using biometrics';

  @override
  String get codeToEnter => 'Enter the login code';

  @override
  String get wrongCodeTryAgain =>
      'An incorrect code has been entered, please try again';

  @override
  String get forgotCode => 'Forgot the code';

  @override
  String get warning => 'Warning';

  @override
  String get resetCodeConfirm =>
      'Are you sure you want to reset your password?';

  @override
  String get createCode => 'Create a login code';

  @override
  String get confirmCode => 'Confirm the code';

  @override
  String get oldCode => 'Enter the old code';

  @override
  String get newCode => 'Enter a new code';

  @override
  String get next => 'Next';

  @override
  String get setupCode => 'Set up the code';

  @override
  String get cancelChanges => 'Undo changes';

  @override
  String get fourDigitCodeWarn => 'You must enter a 4-digit numeric code';

  @override
  String get codeSaved => 'The code was saved successfully';

  @override
  String get differentCodes => 'The entered codes don\'t match';

  @override
  String get wrongCode => 'An incorrect code has been entered';

  @override
  String get biometricsError => 'Biometrics usage error';

  @override
  String get biometricsErrorDesc =>
      'Make sure that the fingerprint or face recognition is set in the device settings';
}

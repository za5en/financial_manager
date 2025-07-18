import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Expenses'**
  String get expenses;

  /// No description provided for @expensesTab.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesTab;

  /// No description provided for @noExpenses.
  ///
  /// In en, this message translates to:
  /// **'There are no expenses for today'**
  String get noExpenses;

  /// No description provided for @incomes.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Earnings'**
  String get incomes;

  /// No description provided for @incomesTab.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get incomesTab;

  /// No description provided for @noIncomes.
  ///
  /// In en, this message translates to:
  /// **'There are no earnings for today'**
  String get noIncomes;

  /// No description provided for @myExpenses.
  ///
  /// In en, this message translates to:
  /// **'My Expenses'**
  String get myExpenses;

  /// No description provided for @myIncomes.
  ///
  /// In en, this message translates to:
  /// **'My Earnings'**
  String get myIncomes;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountName;

  /// No description provided for @accountNoName.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get accountNoName;

  /// No description provided for @articleName.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get articleName;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @deleteExpense.
  ///
  /// In en, this message translates to:
  /// **'Delete expense'**
  String get deleteExpense;

  /// No description provided for @deleteIncome.
  ///
  /// In en, this message translates to:
  /// **'Delete income'**
  String get deleteIncome;

  /// No description provided for @createError.
  ///
  /// In en, this message translates to:
  /// **'Creation error'**
  String get createError;

  /// No description provided for @editError.
  ///
  /// In en, this message translates to:
  /// **'Editing error'**
  String get editError;

  /// No description provided for @createErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'All required fields must be filled in (all except the comment)'**
  String get createErrorDesc;

  /// No description provided for @cancelCreate.
  ///
  /// In en, this message translates to:
  /// **'Cancel creation'**
  String get cancelCreate;

  /// No description provided for @cancelEdit.
  ///
  /// In en, this message translates to:
  /// **'Cancel editing'**
  String get cancelEdit;

  /// No description provided for @cancelEditDesc.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to undo the changes?'**
  String get cancelEditDesc;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteExpenseDesc.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to remove the expense?'**
  String get deleteExpenseDesc;

  /// No description provided for @deleteIncomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete the income?'**
  String get deleteIncomeDesc;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'My History'**
  String get history;

  /// No description provided for @historyStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get historyStart;

  /// No description provided for @historyEnd.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get historyEnd;

  /// No description provided for @historySort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get historySort;

  /// No description provided for @historySum.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get historySum;

  /// No description provided for @sortByDate.
  ///
  /// In en, this message translates to:
  /// **'By date'**
  String get sortByDate;

  /// No description provided for @sortBySum.
  ///
  /// In en, this message translates to:
  /// **'By amount'**
  String get sortBySum;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions were found for the specified period'**
  String get noTransactions;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get account;

  /// No description provided for @accountTab.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTab;

  /// No description provided for @accountBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get accountBalance;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @ruble.
  ///
  /// In en, this message translates to:
  /// **'Russian ruble'**
  String get ruble;

  /// No description provided for @dollar.
  ///
  /// In en, this message translates to:
  /// **'US dollar'**
  String get dollar;

  /// No description provided for @euro.
  ///
  /// In en, this message translates to:
  /// **'Euro'**
  String get euro;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'My Articles'**
  String get articles;

  /// No description provided for @articlesTab.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articlesTab;

  /// No description provided for @findArticles.
  ///
  /// In en, this message translates to:
  /// **'Find an article'**
  String get findArticles;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'System theme'**
  String get darkTheme;

  /// No description provided for @mainColor.
  ///
  /// In en, this message translates to:
  /// **'Main color'**
  String get mainColor;

  /// No description provided for @sounds.
  ///
  /// In en, this message translates to:
  /// **'Sounds'**
  String get sounds;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @passwordCode.
  ///
  /// In en, this message translates to:
  /// **'Password code'**
  String get passwordCode;

  /// No description provided for @syncronization.
  ///
  /// In en, this message translates to:
  /// **'Synchronization'**
  String get syncronization;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language selection'**
  String get language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get about;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @biometrics.
  ///
  /// In en, this message translates to:
  /// **'Log in using biometrics'**
  String get biometrics;

  /// No description provided for @codeToEnter.
  ///
  /// In en, this message translates to:
  /// **'Enter the login code'**
  String get codeToEnter;

  /// No description provided for @wrongCodeTryAgain.
  ///
  /// In en, this message translates to:
  /// **'An incorrect code has been entered, please try again'**
  String get wrongCodeTryAgain;

  /// No description provided for @forgotCode.
  ///
  /// In en, this message translates to:
  /// **'Forgot the code'**
  String get forgotCode;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @resetCodeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset your password?'**
  String get resetCodeConfirm;

  /// No description provided for @createCode.
  ///
  /// In en, this message translates to:
  /// **'Create a login code'**
  String get createCode;

  /// No description provided for @confirmCode.
  ///
  /// In en, this message translates to:
  /// **'Confirm the code'**
  String get confirmCode;

  /// No description provided for @oldCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the old code'**
  String get oldCode;

  /// No description provided for @newCode.
  ///
  /// In en, this message translates to:
  /// **'Enter a new code'**
  String get newCode;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @setupCode.
  ///
  /// In en, this message translates to:
  /// **'Set up the code'**
  String get setupCode;

  /// No description provided for @cancelChanges.
  ///
  /// In en, this message translates to:
  /// **'Undo changes'**
  String get cancelChanges;

  /// No description provided for @fourDigitCodeWarn.
  ///
  /// In en, this message translates to:
  /// **'You must enter a 4-digit numeric code'**
  String get fourDigitCodeWarn;

  /// No description provided for @codeSaved.
  ///
  /// In en, this message translates to:
  /// **'The code was saved successfully'**
  String get codeSaved;

  /// No description provided for @differentCodes.
  ///
  /// In en, this message translates to:
  /// **'The entered codes don\'t match'**
  String get differentCodes;

  /// No description provided for @wrongCode.
  ///
  /// In en, this message translates to:
  /// **'An incorrect code has been entered'**
  String get wrongCode;

  /// No description provided for @biometricsError.
  ///
  /// In en, this message translates to:
  /// **'Biometrics usage error'**
  String get biometricsError;

  /// No description provided for @biometricsErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'Make sure that the fingerprint or face recognition is set in the device settings'**
  String get biometricsErrorDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

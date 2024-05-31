import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CoinApp';

  @override
  String get content => 'Welcome to Coin App';

  @override
  String get welcome => 'Let\'s track your expenses';

  @override
  String get balance => 'Total Balance';

  @override
  String get expenses => 'Expenses';

  @override
  String get message => 'Recent Transactions';

  @override
  String get view => 'View All';

  @override
  String get icon => 'Home';

  @override
  String get iconS => 'Stats';

  @override
  String get summaryOfTransactions => 'The summary of your transactions';

  @override
  String get yourTransactions => 'Your Transactions';

  @override
  String get add => 'Add your expenses here';

  @override
  String get category => 'Category';

  @override
  String get addE => 'Add expense';

  @override
  String get newc => 'Add Category';

  @override
  String get sec => 'New Category Name';

  @override
  String get log => 'Login';

  @override
  String get reg => 'Register';
}

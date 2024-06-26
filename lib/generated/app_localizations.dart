import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'CoinApp'**
  String get appTitle;

  /// No description provided for @content.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido a Coin App'**
  String get content;

  /// No description provided for @welcome.
  ///
  /// In es, this message translates to:
  /// **'Vamos a rastrear tus gastos'**
  String get welcome;

  /// No description provided for @balance.
  ///
  /// In es, this message translates to:
  /// **'Saldo Total'**
  String get balance;

  /// No description provided for @expenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get expenses;

  /// No description provided for @message.
  ///
  /// In es, this message translates to:
  /// **'Transacciones Recientes'**
  String get message;

  /// No description provided for @view.
  ///
  /// In es, this message translates to:
  /// **'Ver Todo'**
  String get view;

  /// No description provided for @icon.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get icon;

  /// No description provided for @iconS.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get iconS;

  /// No description provided for @summaryOfTransactions.
  ///
  /// In es, this message translates to:
  /// **'El resumen de tus transacciones'**
  String get summaryOfTransactions;

  /// No description provided for @yourTransactions.
  ///
  /// In es, this message translates to:
  /// **'Tus Transacciones'**
  String get yourTransactions;

  /// No description provided for @add.
  ///
  /// In es, this message translates to:
  /// **'Agrega tus gastos aquí'**
  String get add;

  /// No description provided for @category.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get category;

  /// No description provided for @addE.
  ///
  /// In es, this message translates to:
  /// **'Agregar gasto'**
  String get addE;

  /// No description provided for @newc.
  ///
  /// In es, this message translates to:
  /// **'Agregar Categoría'**
  String get newc;

  /// No description provided for @sec.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Nombre de Categoría'**
  String get sec;

  /// No description provided for @log.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get log;

  /// No description provided for @reg.
  ///
  /// In es, this message translates to:
  /// **'Registrar'**
  String get reg;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

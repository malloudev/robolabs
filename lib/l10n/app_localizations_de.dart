// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get typewriterMessageOne => 'Lernen';

  @override
  String get typewriterMessageTwo => 'Erstellen';

  @override
  String get typewriterMessageThree => 'Innovieren';

  @override
  String get oauthInfo => 'Mit Google oder Apple einloggen';

  @override
  String get loginMessage => 'Neuen Account erstellen';

  @override
  String get loginButton => 'Erstellen';

  @override
  String get enterName => 'Gebe einen namen für diesen account ein';
}

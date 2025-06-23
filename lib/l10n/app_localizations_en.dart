// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get typewriterMessageOne => 'Learn';

  @override
  String get typewriterMessageTwo => 'Create';

  @override
  String get typewriterMessageThree => 'Innovate';

  @override
  String get oauthInfo => 'Login via Google or Apple OAuth';

  @override
  String get loginMessage => 'Create New Profile';

  @override
  String get loginButton => 'Create';

  @override
  String get enterName => 'Enter a name for your account';

  @override
  String get homepageLabel => 'Home';

  @override
  String get practiceLabel => 'Practice';

  @override
  String get coursesLabel => 'Courses';

  @override
  String get filesLabel => 'File History';
}

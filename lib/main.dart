import 'package:flutter/material.dart';
import 'package:path/path.dart';

import './components/databaseWrapper.dart';
import './l10n/app_localizations.dart';
import './routes/splash.dart';
import './routes/overview.dart';
import './routes/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseWrapper.ensureInitialized();

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      routes: <String, WidgetBuilder>{
        '/': (_) => SplashScreen(),
        '/overview': (_) => OverviewRoute(),
        '/settings': (_) => SettingsRoute()
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './l10n/app_localizations.dart';
import './routes/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> db = openDatabase(
    join(await getDatabasesPath(), 'robolabs.db'),
    version: 1,
    onCreate: (Database db, int version) async {
      final batch = db.batch();

      batch.execute('CREATE TABLE IF NOT EXISTS userdata(id INTEGER PRIMARY KEY AUTOINCREMENT)');
      batch.execute('CREATE TABLE IF NOT EXISTS courses(id INTEGER PRIMARY KEY AUTOINCREMENT)');
      batch.execute('CREATE TABLE IF NOT EXISTS preferences(id INTEGER PRIMARY KEY AUTOINCREMENT)');
      batch.execute('CREATE TABLE IF NOT EXISTS preferences(id INTEGER PRIMARY KEY AUTOINCREMENT)');

      await batch.commit();
    }
  );

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
        '/': (_) => SplashScreen()
      },
    );
  }
}
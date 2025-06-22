import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:robolabs/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';

import '../overview/home.dart';

class OverviewRoute extends StatefulWidget {
  const OverviewRoute({ super.key });

  @override
  State<OverviewRoute> createState() => _OverviewState();
}

class _OverviewState extends State<OverviewRoute> {
  String _versionDetails = '';
  int _currentIndex = 0;

  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo pkg) {
      setState(() => _versionDetails = 'Build:${kDebugMode ? 'debug' : 'release'} - ${pkg.version} (${Platform.operatingSystem})');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * .75,
        child: Drawer(
          child: Column(children: [
            Positioned(
              top: 8.0,
              left: 8.0,
              child: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded), onPressed: () {
                Navigator.of(context).pop();
              }),
            )
          ])
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.homepageLabel
          )
        ]
      )
    );
  }
}
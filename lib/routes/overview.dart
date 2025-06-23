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
  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: Theme.of(context).colorScheme,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.homepageLabel
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school_rounded),
              label: AppLocalizations.of(context)!.practiceLabel
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.account_tree_rounded),
                label: AppLocalizations.of(context)!.coursesLabel
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.folder_special_rounded),
                label: AppLocalizations.of(context)!.filesLabel
            )
          ],
          onTap: (int index) {
            _currentIndex = index;
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    HomePage(),

                  ].map((Widget element) => Padding(
                    padding: EdgeInsets.only(top: 48.0, bottom: 12.0),
                    child: element,
                  )).toList() as List<Widget>
              ),
            ),
            Positioned(
                top: 8.0,
                right: 8.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(icon: const Icon(Icons.settings), iconSize: 28.0, onPressed: () {
                      setState(() => _pageController.animateToPage(_currentIndex = 0, duration: Duration(microseconds: 1), curve: Curves.linear));
                      Navigator.of(context).pushNamed('/settings');
                    }),
                    IconButton(icon: const Icon(Icons.account_circle), iconSize: 28.0, onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    })
                  ],
                )
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(_versionDetails, style: const TextStyle(
                fontSize: 12.0,
                color: Color.fromARGB(255, 66, 66, 66),
              )),
            ),
          ],
        ),
      )
    );
  }
}
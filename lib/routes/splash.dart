import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.hardEdge,
        children: [

        ],
      ),
    );
  }
}
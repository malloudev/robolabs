import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snow_fall_animation/snow_fall_animation.dart';
import 'package:typewritertext/typewritertext.dart';

import '../l10n/app_localizations.dart';

const Key _snowFallPersistenceKey = Key('snowFallAnim');

class SplashScreen extends StatelessWidget {
  const SplashScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    var Size(width: devWidth, height: devHeight) = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.hardEdge,
        children: [
          SizedBox( // Title Splash Container
            width: double.infinity,
            height: devHeight / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/splash.png',
                  fit: BoxFit.scaleDown,
                ),
                TypeWriter(
                  controller: TypeWriterController.fromValue(
                    TypeWriterValue([
                      AppLocalizations.of(context)!.typewriterMessageOne,
                      AppLocalizations.of(context)!.typewriterMessageTwo,
                      AppLocalizations.of(context)!.typewriterMessageThree,
                    ]),
                    duration: Duration(milliseconds: 185),
                    repeat: true
                  ),
                  builder: (BuildContext context, var value) => Text(
                    value.text,
                    maxLines: 1,
                  ),
                )
              ],
            )
          ),
          SizedBox( // Login Options
            width: double.infinity,
            height: devHeight / 3,
            child: Stack(children: [

            ]),
          ),
          SizedBox( // Login using OAuth
            width: double.infinity,
            height: devHeight / 3,
            child: Stack(children: [

            ]),
          ),
          IgnorePointer( // Nice and simple snow animation
            child: const SnowFallAnimation(
              key: _snowFallPersistenceKey,
              config: SnowfallConfig(
                numberOfSnowflakes: 5,
                speed: .5,
                useEmoji: true,
                customEmojis: ['❄️', '❅', '❆']
              )
            ),
          )
        ],
      ),
    );
  }
}
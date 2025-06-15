import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snow_fall_animation/snow_fall_animation.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:auth_buttons/auth_buttons.dart';

import '../l10n/app_localizations.dart';

const Key _snowFallPersistenceKey = Key('snowFallAnim');
final TextEditingController _textEditingController = TextEditingController();

class SplashScreen extends StatelessWidget {
  const SplashScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    var Size(width: devWidth, height: devHeight) = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Column(
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container( // Login Options
                width: double.infinity,
                height: devHeight / 3,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [ BoxShadow(blurRadius: 8.0) ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.loginMessage,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    TextField(
                      controller: _textEditingController,
                      autocorrect: false,
                    ),
                    GestureDetector(
                      onTapUp: (_) async {
                        if(_textEditingController.text.length > 3) {
                          final content = _textEditingController.text;
                          _textEditingController.clear();

                          // TODO
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Center(
                            child: Text(AppLocalizations.of(context)!.loginButton),
                          ),
                        ),
                      )
                    )
                  ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container( // TODO: Login using OAuth
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [ BoxShadow(blurRadius: 8.0) ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: GoogleAuthButton(
                        style: AuthButtonStyle(
                          borderRadius: 8.0,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: AppleAuthButton(
                        style: AuthButtonStyle(
                          borderRadius: 8.0,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0)
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.oauthInfo,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface
                        ),
                      ),
                    )
                  ]
                ),
              ),
            )
          ],
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
      ])
    );
  }
}
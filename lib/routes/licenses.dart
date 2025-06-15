import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LicenseRoute extends StatelessWidget {
  const LicenseRoute({ super.key });

  @override
  Widget build(BuildContext context) {
    final mediaQueryCached = MediaQuery.of(context);
    final themeCached = Theme.of(context);

    return FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold();
          }

          return Scaffold(body: Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                    height: mediaQueryCached.size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('${snapshot.data!.appName[0].toUpperCase()}${snapshot.data!.appName.substring(1)}', textScaler: TextScaler.linear(1.4),)),
                        Center(child: Text(snapshot.data!.version)),
                        Center(child: const Text('Copyright 2025 Malloudev')),
                      ],
                    )
                ),
                Positioned.fill(
                    top: mediaQueryCached.size.height * 0.2,
                    child: Container(
                      width: mediaQueryCached.size.width,
                      height: mediaQueryCached.size.height * 0.8,
                      color: themeCached.colorScheme.surface,
                      child: FutureBuilder(
                        future: LicenseRegistry.licenses.toList(),
                        builder: (BuildContext context, AsyncSnapshot<List<LicenseEntry>> snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const Scaffold(
                              body: Center(child: Text('Loading..')),
                            );
                          }

                          final mappings = {};
                          for(int i = 0; i < snapshot.data!.length; i++) {
                            for(final String package in snapshot.data![i].packages) {
                              if(!mappings.containsKey(package)) {
                                mappings[package] = [];
                              }

                              mappings[package].add(snapshot.data![i].paragraphs.map(
                                      (paragraph) => paragraph.text
                              ).join('\n'));
                            }
                          }

                          final licenses = [];
                          for(final String key in mappings.keys) {
                            licenses.add({ 'title': key, 'licenses': mappings[key] });
                          }

                          return Padding(
                            padding: EdgeInsets.only(bottom: 32.0,),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: licenses.length,
                                itemBuilder: (BuildContext context, int num) => GestureDetector(
                                  onTap: () {
                                    final correspondingLicenses = licenses[num]['licenses'];

                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return Scaffold(
                                              body: Stack(children: [
                                                Positioned(
                                                    top: 32.0,
                                                    left: 18.0,
                                                    child: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded), onPressed: () {
                                                      Navigator.of(context).pop();
                                                    })
                                                ),
                                                Align(
                                                    alignment: Alignment.topCenter,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 82.0, bottom: 16.0),
                                                      child: Text('${licenses[num]['title']}', textScaler: TextScaler.linear(1.4)),
                                                    )
                                                ),
                                                Center(
                                                    child: SizedBox(
                                                      width: mediaQueryCached.size.width * 0.9,
                                                      height: mediaQueryCached.size.height * 0.7,
                                                      child: ListView.builder(
                                                          physics: const BouncingScrollPhysics(),
                                                          itemCount: correspondingLicenses.length,
                                                          itemBuilder: (_, int index) => Text('${correspondingLicenses[index]}\n\n')
                                                      ),
                                                    )
                                                ),
                                              ])
                                          );
                                        }
                                    ));
                                  },
                                  child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${licenses[num]['title']}'),
                                              Text('${licenses[num]['licenses'].length} License${licenses[num]['licenses'].length > 1 ? 's' : ''}')
                                            ]
                                        ),
                                      )
                                  ),
                                )
                            ),
                          );
                        },
                      ),
                    )
                ),
                Positioned(
                    top: 32.0,
                    left: 18.0,
                    child: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded), onPressed: () {
                      Navigator.of(context).pop();
                    })
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 32.0,
                      color: themeCached.colorScheme.surface,
                      width: mediaQueryCached.size.width,
                      child: Center(
                          child: const Text('Powered by Flutter')
                      )
                  ),
                )
              ]
          ));
        }
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:store_checker/store_checker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String source = 'None';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Source installationSource;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      installationSource = await StoreChecker.getSource;
    } on PlatformException {
      installationSource = Source.UNKNOWN;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      switch(installationSource){
        case Source.IS_INSTALLED_FROM_PLAY_STORE:
          source = "Play Store";
          break;
        case Source.IS_INSTALLED_FROM_LOCAL_SOURCE:
          source = "Local source";
          break;
        case Source.IS_INSTALLED_FROM_OTHER_STORE:
          source = "Other store";
          break;
        case Source.IS_INSTALLED_FROM_APP_STORE:
          source = "App Store";
          break;
        case Source.IS_INSTALLED_FROM_TEST_FLIGHT:
          source = "Test Flight";
          break;
        case Source.UNKNOWN:
          source = "Unknown source";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Installed from: $source\n'),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

enum Source {
  IS_INSTALLED_FROM_PLAY_STORE,
  IS_INSTALLED_FROM_LOCAL_SOURCE,
  IS_INSTALLED_FROM_OTHER_STORE,
  IS_INSTALLED_FROM_APP_STORE,
  IS_INSTALLED_FROM_TEST_FLIGHT,
  UNKNOWN
}

class StoreChecker {
  static const MethodChannel _channel = const MethodChannel('store_checker');

  /* Get origin of installed apk/ipa */
  static Future<Source> get getSource async {
    final String sourceName = await _channel.invokeMethod('getSource');
    if (Platform.isAndroid) {
      if (sourceName == null) {
        // Installed apk using adb commands or side loading or downloaded from any cloud service
        return Source.IS_INSTALLED_FROM_LOCAL_SOURCE;
      } else if (sourceName.compareTo('com.android.vending') == 0) {
        // Installed apk from Google Play Store
        return Source.IS_INSTALLED_FROM_PLAY_STORE;
      } else {
        // Installed apk from Amazon app store or other markets
        return Source.IS_INSTALLED_FROM_OTHER_STORE;
      }
    } else if (Platform.isIOS) {
      if (sourceName.isEmpty) {
        // Downloaded ipa using cloud service and installed
        return Source.IS_INSTALLED_FROM_LOCAL_SOURCE;
      } else if (sourceName.compareTo('AppStore') == 0) {
        // Installed ipa from App Store
        return Source.IS_INSTALLED_FROM_APP_STORE;
      } else {
        // Installed ipa from Test Flight
        return Source.IS_INSTALLED_FROM_TEST_FLIGHT;
      }
    }
    // Installed from Unknown source
    return Source.UNKNOWN;
  }
}

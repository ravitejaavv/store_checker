import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/* Source is where apk/ipa is available to Download */
enum Source {
  IS_INSTALLED_FROM_PLAY_STORE,
  IS_INSTALLED_FROM_PLAY_PACKAGE_INSTALLER,
  IS_INSTALLED_FROM_RU_STORE,
  IS_INSTALLED_FROM_LOCAL_SOURCE,
  IS_INSTALLED_FROM_AMAZON_APP_STORE,
  IS_INSTALLED_FROM_HUAWEI_APP_GALLERY,
  IS_INSTALLED_FROM_SAMSUNG_GALAXY_STORE,
  IS_INSTALLED_FROM_SAMSUNG_SMART_SWITCH_MOBILE,
  IS_INSTALLED_FROM_OPPO_APP_MARKET,
  IS_INSTALLED_FROM_XIAOMI_GET_APPS,
  IS_INSTALLED_FROM_VIVO_APP_STORE,
  IS_INSTALLED_FROM_OTHER_SOURCE,
  IS_INSTALLED_FROM_APP_STORE,
  IS_INSTALLED_FROM_TEST_FLIGHT,
  UNKNOWN
}

/* Store Checker is useful to find the origin of installed apk/ipa */
class StoreChecker {
  static const MethodChannel _channel = const MethodChannel('store_checker');

  /* Get origin of installed apk/ipa */
  static Future<Source> get getSource async {
    final String? sourceName = await _channel.invokeMethod('getSource');
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (sourceName == null) {
        // Installed apk using adb commands or side loading or downloaded from any cloud service
        return Source.IS_INSTALLED_FROM_LOCAL_SOURCE;
      } else if (sourceName.compareTo('com.android.vending') == 0) {
        // Installed apk from Google Play Store
        return Source.IS_INSTALLED_FROM_PLAY_STORE;
      } else if (sourceName.compareTo('com.google.android.packageinstaller') == 0) {
        // Installed apk from Google Package installer/ firebase app tester
        return Source.IS_INSTALLED_FROM_PLAY_PACKAGE_INSTALLER;
      } else if (sourceName.compareTo('com.amazon.venezia') == 0) {
        // Installed apk from Amazon App Store
        return Source.IS_INSTALLED_FROM_AMAZON_APP_STORE;
      } else if (sourceName.compareTo('com.huawei.appmarket') == 0) {
        // Installed apk from Huawei App Store
        return Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY;
      } else if (sourceName.compareTo('com.sec.android.app.samsungapps') == 0) {
        // Installed apk from Samsung App Store
        return Source.IS_INSTALLED_FROM_SAMSUNG_GALAXY_STORE;
      } else if (sourceName.compareTo('com.sec.android.easyMover') == 0) {
        // Installed apk from Samsung Smart Switch Mobile
        return Source.IS_INSTALLED_FROM_SAMSUNG_SMART_SWITCH_MOBILE;
      } else if (sourceName.compareTo('com.oppo.market') == 0) {
        // Installed apk from Oppo App Store
        return Source.IS_INSTALLED_FROM_OPPO_APP_MARKET;
      } else if (sourceName.compareTo('com.xiaomi.mipicks') == 0) {
        // Installed apk from Xiaomi App Store
        return Source.IS_INSTALLED_FROM_XIAOMI_GET_APPS;
      } else if (sourceName.compareTo('com.vivo.appstore') == 0) {
        // Installed apk from Vivo App Store
        return Source.IS_INSTALLED_FROM_VIVO_APP_STORE;
      } else if (sourceName.compareTo('ru.vk.store') == 0) {
        // Installed apk from RuStore
        return Source.IS_INSTALLED_FROM_RU_STORE;
      } else {
        // Installed apk from Amazon app store or other markets
        return Source.IS_INSTALLED_FROM_OTHER_SOURCE;
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      if (sourceName == null) {
        // Unknown source when null on iOS
        return Source.UNKNOWN;
      } else if (sourceName.isEmpty) {
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

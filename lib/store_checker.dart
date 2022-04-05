import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/* Source is where apk/ipa is available to Download */
enum Source {
  PLAY_STORE,
  CAFE_BAZAAR,
  LOCAL_SOURCE,
  AMAZON_APP_STORE,
  HUAWEI_APP_GALLERY,
  SAMSUNG_GALAXY_STORE,
  OPPO_APP_MARKET,
  XIAOMI_GET_APPS,
  VIVO_APP_STORE,
  APP_STORE,
  TEST_FLIGHT,
  OTHER_SOURCE,
  UNKNOWN
}

/* Store Checker is useful to find the origin of installed apk/ipa */
class StoreChecker {
  static const MethodChannel _channel = const MethodChannel('store_checker');

  static Future<String?> get sourceName async {
    return await _channel.invokeMethod('getSource');
  }

  /* Get origin of installed apk/ipa */
  static Future<Source> get source async {
    final String? sourceName = await StoreChecker.sourceName;

    if (Platform.isAndroid) {
      if (sourceName == null) {
        // Installed apk using adb commands or side loading or downloaded from any cloud service
        return Source.LOCAL_SOURCE;
      } else if (sourceName.compareTo('com.android.vending') == 0) {
        // Installed apk from Google Play Store
        return Source.PLAY_STORE;
      } else if (sourceName.compareTo('com.farsitel.bazaar') == 0) {
        // Installed apk from Vivo App Store
        return Source.CAFE_BAZAAR;
      } else if (sourceName.compareTo('com.amazon.venezia') == 0) {
        // Installed apk from Amazon App Store
        return Source.AMAZON_APP_STORE;
      } else if (sourceName.compareTo('com.huawei.appmarket') == 0) {
        // Installed apk from Huawei App Store
        return Source.HUAWEI_APP_GALLERY;
      } else if (sourceName.compareTo('com.sec.android.app.samsungapps') == 0) {
        // Installed apk from Samsung App Store
        return Source.SAMSUNG_GALAXY_STORE;
      } else if (sourceName.compareTo('com.oppo.market') == 0) {
        // Installed apk from Oppo App Store
        return Source.OPPO_APP_MARKET;
      } else if (sourceName.compareTo('com.xiaomi.mipicks') == 0) {
        // Installed apk from Xiaomi App Store
        return Source.XIAOMI_GET_APPS;
      } else if (sourceName.compareTo('com.vivo.appstore') == 0) {
        // Installed apk from Vivo App Store
        return Source.VIVO_APP_STORE;
      } else {
        // Installed apk from Amazon app store or other markets
        return Source.OTHER_SOURCE;
      }
    } else if (Platform.isIOS) {
      if (sourceName == null) {
        // Unknown source when null on iOS
        return Source.UNKNOWN;
      } else if (sourceName.isEmpty) {
        // Downloaded ipa using cloud service and installed
        return Source.LOCAL_SOURCE;
      } else if (sourceName.compareTo('AppStore') == 0) {
        // Installed ipa from App Store
        return Source.APP_STORE;
      } else {
        // Installed ipa from Test Flight
        return Source.TEST_FLIGHT;
      }
    }
    // Installed from Unknown source
    return Source.UNKNOWN;
  }
}

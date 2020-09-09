
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

enum Source{
  IS_INSTALLED_FROM_PLAY_STORE, IS_INSTALLED_FROM_LOCAL_SOURCE, IS_INSTALLED_FROM_OTHER_STORE, IS_INSTALLED_FROM_APP_STORE, IS_INSTALLED_FROM_TEST_FLIGHT, UNKNOWN
}

class StoreChecker {
  
  static const MethodChannel _channel =
      const MethodChannel('store_checker');

  static Future<Source> get getSource async {
    final String sourceName = await _channel.invokeMethod('getSource');
    if(Platform.isAndroid){
      if(sourceName == null){
        return Source.IS_INSTALLED_FROM_LOCAL_SOURCE;
      }else if(sourceName.compareTo('com.android.vending') == 0){
        return Source.IS_INSTALLED_FROM_PLAY_STORE;
      }else{
        return Source.IS_INSTALLED_FROM_OTHER_STORE;
      }
    }else if(Platform.isIOS){
      if(sourceName.isEmpty){
        return Source.IS_INSTALLED_FROM_LOCAL_SOURCE;
      }else if(sourceName.compareTo('AppStore') == 0){
        return Source.IS_INSTALLED_FROM_APP_STORE;
      }else{
        return Source.IS_INSTALLED_FROM_TEST_FLIGHT;
      }
    }
    return Source.UNKNOWN;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store_checker/store_checker.dart';

void main() {
  const channel = MethodChannel('store_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('getSource', (tester) async {
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (message) async {
        return 'com.android.vending';
      },
    );
    expect(await StoreChecker.getSource, Source.IS_INSTALLED_FROM_PLAY_STORE);
  });
}

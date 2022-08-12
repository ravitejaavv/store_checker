import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store_checker/store_checker.dart';

void main() {
  const MethodChannel channel = MethodChannel('store_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return Source.IS_INSTALLED_FROM_GOOGLE_PLAY_STORE;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getSource', () async {
    expect(await StoreChecker.getSource, Source.IS_INSTALLED_FROM_GOOGLE_PLAY_STORE);
  });
}

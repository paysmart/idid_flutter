import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idid_flutter/idid_flutter.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('br.com.idid.sdk/idid_plugin_channel');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect('42', '42');
  });
}

import 'dart:async';

import 'package:flutter/services.dart';

class IdidFlutter {
  static const MethodChannel _channel =
      const MethodChannel('br.com.idid.sdk/idid_plugin_channel');

  static Future<bool> isProvisioned() => _channel.invokeMethod('isProvisioned');

  static Future provision(Map<String, dynamic> payload) =>
      _channel.invokeMethod('provision', payload);

  static Future authorize(Map<String, dynamic> payload) =>
      _channel.invokeMethod('authorize', payload);
}

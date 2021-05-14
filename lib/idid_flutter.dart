import 'dart:async';

import 'package:flutter/services.dart';

class IdidFlutter {
  static const MethodChannel _channel =
      const MethodChannel('br.com.idid.sdk/idid_plugin_channel');

  static Future<dynamic> isProvisioned() =>
      _channel.invokeMethod('isProvisioned');

  static Future provision(Map<String, dynamic> payload) =>
      _channel.invokeMethod('provision', payload);

  static Future unProvision(Map<String, dynamic> payload) =>
      _channel.invokeMethod('unProvision', payload);

  static Future authorize(Map<String, dynamic> payload) =>
      _channel.invokeMethod('authorize', payload);
}

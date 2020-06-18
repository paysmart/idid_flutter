import 'dart:async';

import 'package:flutter/services.dart';

const idid_plugin_channel = 'br.com.idid.sdk/idid_plugin_channel';

/*
* Maybe add some convenient data structures to use as payloads
*
* */

class IdidFlutter {
  static const MethodChannel _channel =
      const MethodChannel(idid_plugin_channel);

  static Future<bool> get isProvisioned async =>
      await _channel.invokeMethod('isProvisioned');

  static Future<void> provision(Map<String, dynamic> payload) async {
    return await _channel.invokeMethod('provision', payload);
  }

  static Future<void> authorize(Map<String, dynamic> payload) async {
    return await _channel.invokeMethod('authorize', payload);
  }
}

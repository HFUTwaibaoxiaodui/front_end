import 'dart:convert';

import 'package:flutter/services.dart';

class AndroidActivityVisitor {
  static const _channel = MethodChannel('activity_visitor');
  static Future getDistance() async {
    double latitude = 32.0;
    double longitude = 118.4;
    Map position = {};
    position['latitude'] = latitude;
    position['longitude'] = longitude;
    return await _channel.invokeMethod('getDistance', jsonEncode(position));
  }

  static Future pickAddress() async {
    return await _channel.invokeMethod('pickAddress');
  }

  static Future navigate(String address) async {
    return await _channel.invokeMethod('navigate', address);
  }
}
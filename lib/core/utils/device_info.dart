// lib/core/utils/device_info.dart
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return "${info.manufacturer} ${info.model}";
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return "${info.name} ${info.model}";
    }
    return "Unknown Device";
  }

  static Future<String> getOSVersion() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return "Android ${info.version.release}";
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return "iOS ${info.systemVersion}";
    }
    return "Unknown OS";
  }
}
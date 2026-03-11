// lib/core/utils/permission_helper.dart
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
}


///how to use it///
// bool granted = await PermissionHelper.requestPermission(Permission.camera);
// if (granted) {
// // Open camera
// }
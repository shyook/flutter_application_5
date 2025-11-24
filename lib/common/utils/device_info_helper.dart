import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoHelper {
  static final String device_info_os_version = 'os_version';
  static final String device_info_model = 'model';

  static final String package_info_version = 'app_version';

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } catch(error) {
      deviceData = {
        "Error": "Failed to get platform version."
      };
    }

    return deviceData;
  }

  static  Future<Map<String, dynamic>> getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      package_info_version: packageInfo.version,
    };
  }

  static Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo info) {
    // var release = info.version.release;
    // var sdkInt = info.version.sdkInt;
    // var manufacturer = info.manufacturer;
    // var model = info.model;

    return {
      device_info_os_version: info.version.release,
      device_info_model: info.model,
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    // var systemName = info.systemName;
    // var version = info.systemVersion;
    // var machine = info.utsname.machine;

    return {
      device_info_os_version: info.systemVersion,
      device_info_model: info.model,
    };
  }
}
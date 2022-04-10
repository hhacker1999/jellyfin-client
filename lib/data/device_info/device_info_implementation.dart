import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:jellyfin_client/domain/device_info/device_info_facade.dart';

class DeviceInfoImplementation implements DeviceInfoFacade {
  late String _deviceInfo, _deviceId, _packageId;
  final DeviceInfoPlugin _deviceinfoPLugin;
  final PackageInfo _packageInfoPlugin;
  DeviceInfoImplementation(
    this._deviceinfoPLugin,
    this._packageInfoPlugin,
  ) {
    _deviceinfoPLugin.androidInfo.then((info) {
      _deviceId = info.id!;
      _deviceInfo = info.host!;
    });
    _packageId = _packageInfoPlugin.buildNumber.isEmpty
        ? "Unknown"
        : _packageInfoPlugin.version;
  }

  @override
  Future<String> getDeviceId() async => _deviceId;

  @override
  Future<String> getDeviceInfo() async => _deviceInfo;

  @override
  Future<String> getPackageInfo() async => _packageId;
  }

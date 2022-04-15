import 'package:jellyfin_client/domain/device_info/device_info_facade.dart';
import 'package:jellyfin_client/domain/storage/storage_facade.dart';

class CreateHeaderUsecase {
  final StorageFacade _storageFacade;
  final DeviceInfoFacade _deviceInfoFacade;

  const CreateHeaderUsecase(this._storageFacade, this._deviceInfoFacade);

  Future<Map<String, String>> execute() async {
    Map<String, String> header = {};
    final bool isLoggedIn = await _storageFacade.doesTokenExist();
    final String deviceId = await _storageFacade.getDeviceId();
    final String deviceName = await _storageFacade.getDeviceName();
    final String version = await _deviceInfoFacade.getPackageInfo();
    if (isLoggedIn) {
      final String token = await _storageFacade.getAuthToken();
      header = {
        'x-emby-authorization':
            'MediaBrowser Client="Jellyfin Client mobile", Device="$deviceName", DeviceId="$deviceId", Version="$version", Token="$token"'
      };
    } else {
      header = {
        'x-emby-authorization':
            'MediaBrowser Client="Jellyfin Client mobile", Device="$deviceName", DeviceId="$deviceId", Version="$version"'
      };
    }
    return header;
  }
}

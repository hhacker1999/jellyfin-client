import 'package:jellyfin_client/domain/auth/auth_facade.dart';
import 'package:jellyfin_client/domain/auth/authenticated_user_response_model.dart';
import 'package:jellyfin_client/domain/device_info/device_info_facade.dart';
import 'package:jellyfin_client/domain/storage/storage_facade.dart';

class AuthenticateUserUsecase {
  final DeviceInfoFacade _deviceInfo;
  final AuthFacade _auth;
  final StorageFacade _storageFacade;

  const AuthenticateUserUsecase(
      this._deviceInfo, this._auth, this._storageFacade);

  Future<void> execute(String username, password) async {
    final String version = await _deviceInfo.getPackageInfo();
    final String device = await _deviceInfo.getDeviceInfo();
    final String deviceId = await _deviceInfo.getDeviceId();
    final AuthenticatedUserResponse user = await _auth.authenticateUser(
        username, password, deviceId, version, device);
    await _storageFacade.storeAuthToken(user.token);
    await _storageFacade.storeUserId(user.userId);
  }
}

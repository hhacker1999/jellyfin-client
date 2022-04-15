import 'package:dio/dio.dart';
import 'package:jellyfin_client/app/constansts.dart';
import 'package:jellyfin_client/domain/auth/auth_facade.dart';
import '../../domain/models/authenticated_user_response_model.dart';

class AuthImplementation implements AuthFacade {
  final Dio _client;

  const AuthImplementation(this._client);

  @override
  Future<void> logoutUser() async {}

  @override
  Future<AuthenticatedUserResponse> authenticateUser(
      String username, password, deviceId, version, device) async {
    try {
      Map<String, String> authMap = {
        "Username": username,
        "Pw": password,
      };
      final String authHeader =
          await _createAuthHeader(device, deviceId, version);
      const String authPath = AppConstants.authUrl;
      final Response response = await _client.post(
          "http://192.168.0.161:8096$authPath",
          data: authMap,
          options: Options(headers: {"x-emby-authorization": authHeader}));
      final AuthenticatedUserResponse data = AuthenticatedUserResponse(
          userId: response.data["User"]["Id"],
          token: response.data["AccessToken"]);
      return data;
    } catch (_) {
      rethrow;
    }
  }

  Future<String> _createAuthHeader(String device, deviceId, version) async {
    String authHeader =
        'MediaBrowser Client="Jellyfin Client mobile", Device="$device", DeviceId="$deviceId", Version="$version"';
    return authHeader;
  }
}

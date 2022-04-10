import 'authenticated_user_response_model.dart';

abstract class AuthFacade {
  Future<AuthenticatedUserResponse> authenticateUser(
      String username, password, deviceId, version, device);
  Future<void> logoutUser();
}

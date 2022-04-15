import '../models/authenticated_user_response_model.dart';

abstract class AuthFacade {
  Future<AuthenticatedUserResponse> authenticateUser(String username,
      String password, String deviceId, String version, String device);
  Future<void> logoutUser();
}

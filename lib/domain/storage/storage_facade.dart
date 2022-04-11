abstract class StorageFacade {
  Future<void> storeAuthToken(String token);
  Future<void> storeUserId(String id);
  Future<String> getAuthToken();
  Future<bool> doesTokenExist();
  Future<bool> doesUserExist();
  Future<String> getUserId();
}

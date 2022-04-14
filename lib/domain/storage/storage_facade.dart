abstract class StorageFacade {
  Future<void> storeAuthToken(String token);
  Future<void> storeUserId(String id);
  Future<void> storeDeviceId(String id);
  Future<void> storeDeviceName(String name);
  Future<String> getAuthToken();
  Future<bool> doesTokenExist();
  Future<bool> doesUserExist();
  Future<String> getUserId();
  Future<String> getDeviceName();
  Future<String> getDeviceId();
}

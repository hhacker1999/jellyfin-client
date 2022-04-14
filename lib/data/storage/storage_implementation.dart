import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jellyfin_client/domain/storage/storage_facade.dart';

class StorageImplementation implements StorageFacade {
  final FlutterSecureStorage _secureStorage;

  const StorageImplementation(this._secureStorage);
  @override
  Future<bool> doesTokenExist() async {
    final bool value = await _secureStorage.containsKey(key: "token");
    return value;
  }

  @override
  Future<bool> doesUserExist() async {
    final bool value = await _secureStorage.containsKey(key: "id");
    return value;
  }

  @override
  Future<String> getAuthToken() async {
    final value = await _secureStorage.read(key: "token");
    return value!;
  }

  @override
  Future<String> getUserId() async {
    final value = await _secureStorage.read(key: "id");
    return value!;
  }

  @override
  Future<void> storeAuthToken(String token) async =>
      await _secureStorage.write(key: "token", value: token);

  @override
  Future<void> storeUserId(String id) async =>
      await _secureStorage.write(key: "id", value: id);

  @override
  Future<String> getDeviceId() async {
    final deviceId = await _secureStorage.read(key: "deviceId");
    return deviceId!;
  }

  @override
  Future<String> getDeviceName() async {
    final host = await _secureStorage.read(key: "deviceName");
    return host!;
  }

  @override
  Future<void> storeDeviceId(String id) async =>
      await _secureStorage.write(key: "deviceId", value: id);

  @override
  Future<void> storeDeviceName(String name) async =>
      await _secureStorage.write(key: "deviceName", value: name);
}

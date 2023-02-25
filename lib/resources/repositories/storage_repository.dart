
import 'package:InstantMC/constants/storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageRepository {
  late final FlutterSecureStorage _storage;
  StorageRepository() {
    _storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
  }

  Future<String?> getTargetServerUrl() async {
    return await _storage.read(key: Storage.targetMachineUrl);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: Storage.token);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: Storage.token, value: token);
  }

  Future<void> saveTargetServerUrl(String targetServerUrl) async {
    await _storage.write(key: Storage.targetMachineUrl, value: targetServerUrl);
  }
}
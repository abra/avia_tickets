import 'local_storage/local_storage_interface.dart';

class LocalStorage {
  LocalStorage({
    required LocalStorageInterface storage,
  }) : _storage = storage;

  final LocalStorageInterface _storage;

  Future<void> storeValue(String key, String value) {
    return _storage.saveValue(key, value);
  }

  Future<String?> getValue(String key) {
    return _storage.getValue(key);
  }
}

import 'local_storage/local_storage_interface.dart';

class LocalStorageRepository {
  LocalStorageRepository({
    required LocalStorageInterface storage,
  }) : _storage = storage;

  final LocalStorageInterface _storage;

  Future<void> saveValue(String key, String value) {
    return _storage.saveValue(key, value);
  }

  Future<String?> getValue(String key) {
    return _storage.getValue(key);
  }
}

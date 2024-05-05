import 'local_storage/local_storage_interface.dart';

class LocalStorageRepository {
  final LocalStorageInterface storage;

  LocalStorageRepository({
    required this.storage,
  });

  Future<void> saveValue(String key, String value) {
    return storage.saveValue(key, value);
  }

  Future<String?> getValue(String key) {
    return storage.getValue(key);
  }
}

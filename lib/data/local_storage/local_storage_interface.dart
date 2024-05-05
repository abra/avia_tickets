abstract interface class LocalStorageInterface {
  Future<void> saveValue(String key, String value);
  Future<String?> getValue(String key);
}
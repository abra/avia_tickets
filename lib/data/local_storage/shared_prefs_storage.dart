import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_interface.dart';

class SharedPrefsStorage implements LocalStorageInterface {
  @override
  Future<String?> getValue(String key) {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getString(key));
  }

  @override
  Future<void> saveValue(String key, String value) {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(key, value));
  }
}

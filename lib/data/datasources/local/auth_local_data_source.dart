// lib/data/datasources/local/auth_local_data_source.dart

import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/storage_key.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl({required this.prefs});

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString(StorageKeys.token, token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(StorageKeys.token);
  }

  @override
  Future<void> clearToken() async {
    await prefs.remove(StorageKeys.token);
  }
}
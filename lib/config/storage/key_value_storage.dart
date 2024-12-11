import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<T?> read<T>(String key) async {
    final prefs = await getSharedPreferences();
    if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else if (T == Map<String, dynamic>) {
      final String? json = prefs.getString(key);
      if (json != null) {
        return jsonDecode(json) as T?;
      }
    } else {
      throw UnimplementedError('Type $T is not supported');
    }
    return null;
  }

  Future<void> write<T>(String key, T value) async {
    final prefs = await getSharedPreferences();
    if (T == int) {
      prefs.setInt(key, value as int);
    } else if (T == String) {
      prefs.setString(key, value as String);
    } else if (T == double) {
      prefs.setDouble(key, value as double);
    } else if (T == bool) {
      prefs.setBool(key, value as bool);
    } else if (T == List<String>) {
      prefs.setStringList(key, value as List<String>);
    } else if (T == Map<String, dynamic>) {
      final String json = jsonEncode(value);
      prefs.setString(key, json);
    } else {
      throw UnimplementedError('Type $T is not supported');
    }
  }

  Future<bool> delete(String key) async {
    final prefs = await getSharedPreferences();
    return await prefs.remove(key);
  }
}

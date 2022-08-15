import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_for_dinner/utils/constants.dart';

class Database {
  // Group Id
  Future<void> setGroupId(String groupId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupId', groupId);
  }

  Future<String> getGroupId() async {
    final prefs = await SharedPreferences.getInstance();
    final groupId = prefs.getString('groupId');
    if (groupId == null) return ' ';
    return groupId;
  }

  // Username
  Future<void> setUsername(String newUsername) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username == null) return ' ';
    return username;
  }

  //Color
  Future<void> setColor(String newColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('color', newColor);
  }

  Future<String> getColor() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getString('color');
    if (color == null) return ' ';
    return color;
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_for_dinner/utils/constants.dart';

class Database {
  Future<void> setGroupId(String groupId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupId', groupId);
  }

  Future<String> getGroupId() async {
    final prefs = await SharedPreferences.getInstance();
    final groupId = prefs.getString('groupId');
    if (groupId == null) return ' ';
    print('returned string' + groupId);
    return groupId;
  }
}

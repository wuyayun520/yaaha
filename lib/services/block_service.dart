import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BlockService {
  static const String _blockedUsersKey = 'blocked_users';

  // 拉黑用户
  static Future<bool> blockUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final blockedUsersJson = prefs.getString(_blockedUsersKey);
      
      List<String> blockedUsers = [];
      if (blockedUsersJson != null) {
        blockedUsers = List<String>.from(json.decode(blockedUsersJson));
      }
      
      if (!blockedUsers.contains(userId)) {
        blockedUsers.add(userId);
        await prefs.setString(_blockedUsersKey, json.encode(blockedUsers));
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error blocking user: $e');
      return false;
    }
  }

  // 取消拉黑用户
  static Future<bool> unblockUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final blockedUsersJson = prefs.getString(_blockedUsersKey);
      
      if (blockedUsersJson != null) {
        List<String> blockedUsers = List<String>.from(json.decode(blockedUsersJson));
        if (blockedUsers.contains(userId)) {
          blockedUsers.remove(userId);
          await prefs.setString(_blockedUsersKey, json.encode(blockedUsers));
          return true;
        }
      }
      
      return false;
    } catch (e) {
      print('Error unblocking user: $e');
      return false;
    }
  }

  // 检查用户是否被拉黑
  static Future<bool> isUserBlocked(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final blockedUsersJson = prefs.getString(_blockedUsersKey);
      
      if (blockedUsersJson != null) {
        final List<String> blockedUsers = List<String>.from(json.decode(blockedUsersJson));
        return blockedUsers.contains(userId);
      }
      
      return false;
    } catch (e) {
      print('Error checking blocked status: $e');
      return false;
    }
  }

  // 获取所有被拉黑的用户
  static Future<List<String>> getBlockedUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final blockedUsersJson = prefs.getString(_blockedUsersKey);
      
      if (blockedUsersJson != null) {
        return List<String>.from(json.decode(blockedUsersJson));
      }
      
      return [];
    } catch (e) {
      print('Error getting blocked users: $e');
      return [];
    }
  }

  // 清除所有拉黑数据（用于测试或重置）
  static Future<void> clearAllBlockedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_blockedUsersKey);
    } catch (e) {
      print('Error clearing blocked data: $e');
    }
  }
} 
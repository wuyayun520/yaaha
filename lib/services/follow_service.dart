import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FollowService {
  static const String _followingUsersKey = 'following_users';

  // 关注用户
  static Future<bool> followUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followingUsersJson = prefs.getString(_followingUsersKey);
      
      List<String> followingUsers = [];
      if (followingUsersJson != null) {
        followingUsers = List<String>.from(json.decode(followingUsersJson));
      }
      
      if (!followingUsers.contains(userId)) {
        followingUsers.add(userId);
        await prefs.setString(_followingUsersKey, json.encode(followingUsers));
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error following user: $e');
      return false;
    }
  }

  // 取消关注用户
  static Future<bool> unfollowUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followingUsersJson = prefs.getString(_followingUsersKey);
      
      if (followingUsersJson != null) {
        List<String> followingUsers = List<String>.from(json.decode(followingUsersJson));
        if (followingUsers.contains(userId)) {
          followingUsers.remove(userId);
          await prefs.setString(_followingUsersKey, json.encode(followingUsers));
          return true;
        }
      }
      
      return false;
    } catch (e) {
      print('Error unfollowing user: $e');
      return false;
    }
  }

  // 检查是否关注了用户
  static Future<bool> isFollowingUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followingUsersJson = prefs.getString(_followingUsersKey);
      
      if (followingUsersJson != null) {
        final List<String> followingUsers = List<String>.from(json.decode(followingUsersJson));
        return followingUsers.contains(userId);
      }
      
      return false;
    } catch (e) {
      print('Error checking following status: $e');
      return false;
    }
  }

  // 获取所有关注的用户
  static Future<List<String>> getFollowingUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followingUsersJson = prefs.getString(_followingUsersKey);
      
      if (followingUsersJson != null) {
        return List<String>.from(json.decode(followingUsersJson));
      }
      
      return [];
    } catch (e) {
      print('Error getting following users: $e');
      return [];
    }
  }

  // 获取关注数量
  static Future<int> getFollowingCount() async {
    try {
      final followingUsers = await getFollowingUsers();
      return followingUsers.length;
    } catch (e) {
      print('Error getting following count: $e');
      return 0;
    }
  }

  // 清除所有关注数据（用于测试或重置）
  static Future<void> clearAllFollowingData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_followingUsersKey);
    } catch (e) {
      print('Error clearing following data: $e');
    }
  }
} 
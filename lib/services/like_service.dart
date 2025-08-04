import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LikeService {
  static const String _likeStatesKey = 'like_states';
  static const String _likeCountsKey = 'like_counts';

  // Get like state for a specific post
  static Future<bool> getLikeState(String postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likeStatesJson = prefs.getString(_likeStatesKey);
      
      if (likeStatesJson != null) {
        final Map<String, dynamic> likeStates = json.decode(likeStatesJson);
        return likeStates[postId] ?? false;
      }
      
      return false;
    } catch (e) {
      print('Error getting like state: $e');
      return false;
    }
  }

  // Set like state for a specific post
  static Future<void> setLikeState(String postId, bool isLiked) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likeStatesJson = prefs.getString(_likeStatesKey);
      
      Map<String, dynamic> likeStates = {};
      if (likeStatesJson != null) {
        likeStates = Map<String, dynamic>.from(json.decode(likeStatesJson));
      }
      
      likeStates[postId] = isLiked;
      
      await prefs.setString(_likeStatesKey, json.encode(likeStates));
    } catch (e) {
      print('Error setting like state: $e');
    }
  }

  // Get like count for a specific post
  static Future<int> getLikeCount(String postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likeCountsJson = prefs.getString(_likeCountsKey);
      
      if (likeCountsJson != null) {
        final Map<String, dynamic> likeCounts = json.decode(likeCountsJson);
        return likeCounts[postId] ?? 0;
      }
      
      return 0;
    } catch (e) {
      print('Error getting like count: $e');
      return 0;
    }
  }

  // Set like count for a specific post
  static Future<void> setLikeCount(String postId, int count) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likeCountsJson = prefs.getString(_likeCountsKey);
      
      Map<String, dynamic> likeCounts = {};
      if (likeCountsJson != null) {
        likeCounts = Map<String, dynamic>.from(json.decode(likeCountsJson));
      }
      
      likeCounts[postId] = count;
      
      await prefs.setString(_likeCountsKey, json.encode(likeCounts));
    } catch (e) {
      print('Error setting like count: $e');
    }
  }

  // Get all like states
  static Future<Map<String, bool>> getAllLikeStates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likeStatesJson = prefs.getString(_likeStatesKey);
      
      if (likeStatesJson != null) {
        final Map<String, dynamic> likeStates = json.decode(likeStatesJson);
        return likeStates.map((key, value) => MapEntry(key, value as bool));
      }
      
      return {};
    } catch (e) {
      print('Error getting all like states: $e');
      return {};
    }
  }

  // Get all like counts
  static Future<Map<String, int>> getAllLikeCounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likeCountsJson = prefs.getString(_likeCountsKey);
      
      if (likeCountsJson != null) {
        final Map<String, dynamic> likeCounts = json.decode(likeCountsJson);
        return likeCounts.map((key, value) => MapEntry(key, value as int));
      }
      
      return {};
    } catch (e) {
      print('Error getting all like counts: $e');
      return {};
    }
  }

  // Clear all like data (for testing or reset)
  static Future<void> clearAllLikeData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_likeStatesKey);
      await prefs.remove(_likeCountsKey);
    } catch (e) {
      print('Error clearing like data: $e');
    }
  }
} 
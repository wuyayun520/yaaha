import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService {
  static const String _reportedPostsKey = 'reported_posts';

  // Report a post
  static Future<bool> reportPost(String postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final reportedPostsJson = prefs.getString(_reportedPostsKey);
      
      List<String> reportedPosts = [];
      if (reportedPostsJson != null) {
        reportedPosts = List<String>.from(json.decode(reportedPostsJson));
      }
      
      if (!reportedPosts.contains(postId)) {
        reportedPosts.add(postId);
        await prefs.setString(_reportedPostsKey, json.encode(reportedPosts));
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error reporting post: $e');
      return false;
    }
  }

  // Check if a post is reported
  static Future<bool> isPostReported(String postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final reportedPostsJson = prefs.getString(_reportedPostsKey);
      
      if (reportedPostsJson != null) {
        final List<String> reportedPosts = List<String>.from(json.decode(reportedPostsJson));
        return reportedPosts.contains(postId);
      }
      
      return false;
    } catch (e) {
      print('Error checking reported post: $e');
      return false;
    }
  }

  // Get all reported posts
  static Future<List<String>> getReportedPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final reportedPostsJson = prefs.getString(_reportedPostsKey);
      
      if (reportedPostsJson != null) {
        return List<String>.from(json.decode(reportedPostsJson));
      }
      
      return [];
    } catch (e) {
      print('Error getting reported posts: $e');
      return [];
    }
  }

  // Clear all reported posts (for testing or reset)
  static Future<void> clearAllReportedPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_reportedPostsKey);
    } catch (e) {
      print('Error clearing reported posts: $e');
    }
  }
}
 
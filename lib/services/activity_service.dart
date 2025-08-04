import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityService {
  static const String _joinedActivitiesKey = 'joined_activities';

  // 获取所有参与的活动
  static Future<List<Map<String, dynamic>>> getJoinedActivities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final activitiesJson = prefs.getString(_joinedActivitiesKey);
      
      if (activitiesJson != null) {
        final List<dynamic> activitiesList = json.decode(activitiesJson);
        return activitiesList.map((item) => Map<String, dynamic>.from(item)).toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }

  // 参与活动
  static Future<bool> joinActivity(Map<String, dynamic> activity) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentActivities = await getJoinedActivities();
      
      // 检查是否已经参与
      final exists = currentActivities.any((item) => 
        item['event_name'] == activity['event_name'] &&
        item['date'] == activity['date']
      );
      
      if (exists) {
        return false; // 已经参与了
      }
      
      // 添加参与时间
      final activityWithTimestamp = {
        ...activity,
        'join_date': DateTime.now().toIso8601String(),
      };
      
      currentActivities.add(activityWithTimestamp);
      
      await prefs.setString(_joinedActivitiesKey, json.encode(currentActivities));
      return true;
    } catch (e) {
      return false;
    }
  }

  // 退出活动
  static Future<bool> leaveActivity(Map<String, dynamic> activity) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentActivities = await getJoinedActivities();
      
      final updatedActivities = currentActivities.where((item) => 
        !(item['event_name'] == activity['event_name'] &&
          item['date'] == activity['date'])
      ).toList();
      
      await prefs.setString(_joinedActivitiesKey, json.encode(updatedActivities));
      return true;
    } catch (e) {
      return false;
    }
  }

  // 检查是否已参与活动
  static Future<bool> isJoined(Map<String, dynamic> activity) async {
    try {
      final activities = await getJoinedActivities();
      return activities.any((item) => 
        item['event_name'] == activity['event_name'] &&
        item['date'] == activity['date']
      );
    } catch (e) {
      return false;
    }
  }
} 
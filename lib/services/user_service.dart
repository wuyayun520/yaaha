import 'dart:convert';
import 'package:flutter/services.dart';

class UserService {
  static List<Map<String, dynamic>> _users = [];
  static bool _isLoaded = false;

  static Future<void> loadUsers() async {
    if (_isLoaded) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/post/motorcycle_users.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      _users = List<Map<String, dynamic>>.from(jsonData['users']);
      _isLoaded = true;
    } catch (e) {
      print('Error loading user data: $e');
      _users = [];
    }
  }

  static List<Map<String, dynamic>> getAllUsers() {
    return List.from(_users);
  }

  static Map<String, dynamic>? getUserById(int id) {
    try {
      return _users.firstWhere((user) => user['id'] == id);
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> getUsersByLocation(String location) {
    return _users.where((user) {
      return user['location'].toString().toLowerCase().contains(location.toLowerCase());
    }).toList();
  }

  static List<Map<String, dynamic>> getUsersByBikeBrand(String brand) {
    return _users.where((user) {
      return user['bike_model'].toString().toLowerCase().contains(brand.toLowerCase());
    }).toList();
  }
} 
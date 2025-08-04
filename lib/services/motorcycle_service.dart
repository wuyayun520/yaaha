import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class MotorcycleService {
  static List<Map<String, dynamic>> _motorcycles = [];
  static bool _isLoaded = false;

  static Future<void> loadMotorcycles() async {
    if (_isLoaded) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/Motorcycle/motorcycle_detailed_info.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      _motorcycles = List<Map<String, dynamic>>.from(
        jsonData['motorcycle_collection']['motorcycles']
      );
      _isLoaded = true;
    } catch (e) {
      print('Error loading motorcycle data: $e');
      _motorcycles = [];
    }
  }

  static List<Map<String, dynamic>> getRandomMotorcycles(int count) {
    if (_motorcycles.isEmpty) return [];
    
    final random = Random();
    final List<Map<String, dynamic>> shuffled = List.from(_motorcycles);
    shuffled.shuffle(random);
    
    return shuffled.take(count).toList();
  }

  static List<Map<String, dynamic>> getAllMotorcycles() {
    return List.from(_motorcycles);
  }

  static Map<String, dynamic>? getMotorcycleById(String id) {
    try {
      return _motorcycles.firstWhere((motorcycle) => motorcycle['id'] == id);
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> getMotorcyclesByBrand(String brand) {
    return _motorcycles.where((motorcycle) {
      final basicInfo = motorcycle['basic_info'] as Map<String, dynamic>;
      return basicInfo['brand'].toString().toLowerCase().contains(brand.toLowerCase());
    }).toList();
  }

  static List<Map<String, dynamic>> getMotorcyclesByCategory(String category) {
    return _motorcycles.where((motorcycle) {
      final basicInfo = motorcycle['basic_info'] as Map<String, dynamic>;
      return basicInfo['category'].toString().toLowerCase().contains(category.toLowerCase());
    }).toList();
  }
} 
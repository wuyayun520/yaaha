import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _favoritesKey = 'favorite_motorcycles';

  // 获取所有收藏的摩托车
  static Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);
      
      if (favoritesJson != null) {
        final List<dynamic> favoritesList = json.decode(favoritesJson);
        return favoritesList.map((item) => Map<String, dynamic>.from(item)).toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }

  // 添加收藏
  static Future<bool> addFavorite(Map<String, dynamic> motorcycle) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentFavorites = await getFavorites();
      
      // 检查是否已经收藏
      final exists = currentFavorites.any((item) => 
        item['basic_info']['brand'] == motorcycle['basic_info']['brand'] &&
        item['basic_info']['model'] == motorcycle['basic_info']['model']
      );
      
      if (exists) {
        return false; // 已经收藏过了
      }
      
      // 添加收藏时间
      final motorcycleWithTimestamp = {
        ...motorcycle,
        'favorite_date': DateTime.now().toIso8601String(),
      };
      
      currentFavorites.add(motorcycleWithTimestamp);
      
      await prefs.setString(_favoritesKey, json.encode(currentFavorites));
      return true;
    } catch (e) {
      return false;
    }
  }

  // 移除收藏
  static Future<bool> removeFavorite(Map<String, dynamic> motorcycle) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentFavorites = await getFavorites();
      
      final updatedFavorites = currentFavorites.where((item) => 
        !(item['basic_info']['brand'] == motorcycle['basic_info']['brand'] &&
          item['basic_info']['model'] == motorcycle['basic_info']['model'])
      ).toList();
      
      await prefs.setString(_favoritesKey, json.encode(updatedFavorites));
      return true;
    } catch (e) {
      return false;
    }
  }

  // 检查是否已收藏
  static Future<bool> isFavorite(Map<String, dynamic> motorcycle) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((item) => 
        item['basic_info']['brand'] == motorcycle['basic_info']['brand'] &&
        item['basic_info']['model'] == motorcycle['basic_info']['model']
      );
    } catch (e) {
      return false;
    }
  }
} 
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileService {
  static const String _userProfileKey = 'user_profile';
  static const String _avatarKey = 'user_avatar_base64';

  // 获取用户信息
  static Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userProfileJson = prefs.getString(_userProfileKey);
      
      if (userProfileJson != null) {
        return Map<String, dynamic>.from(json.decode(userProfileJson));
      }
      
      return {
        'username': 'UserName',
        'bio': 'A free motorcyclist.',
      };
    } catch (e) {
      return {
        'username': 'UserName',
        'bio': 'A free motorcyclist.',
      };
    }
  }

  // 保存用户信息
  static Future<bool> saveUserProfile({
    String? username,
    String? bio,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentProfile = await getUserProfile();
      
      final updatedProfile = {
        ...currentProfile,
        if (username != null) 'username': username,
        if (bio != null) 'bio': bio,
      };
      
      await prefs.setString(_userProfileKey, json.encode(updatedProfile));
      return true;
    } catch (e) {
      return false;
    }
  }

  // 获取头像数据
  static Future<Uint8List?> getAvatarData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final avatarBase64 = prefs.getString(_avatarKey);
      
      if (avatarBase64 != null && avatarBase64.isNotEmpty) {
        return base64Decode(avatarBase64);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 保存头像
  static Future<bool> saveAvatar(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64String = base64Encode(bytes);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_avatarKey, base64String);
      return true;
    } catch (e) {
      return false;
    }
  }

  // 选择并保存头像
  static Future<bool> pickAndSaveAvatar() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 80,
      );
      
      if (image != null) {
        return await saveAvatar(File(image.path));
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // 删除头像
  static Future<bool> deleteAvatar() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_avatarKey);
      return true;
    } catch (e) {
      return false;
    }
  }
} 
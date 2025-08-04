class UserModel {
  final int userId;
  final String name;
  final String usericon;
  final String username;
  final String? location;

  UserModel({
    required this.userId,
    required this.name,
    required this.usericon,
    required this.username,
    this.location,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['id'] ?? 0,
      name: map['name'] ?? '',
      usericon: map['profile_image'] ?? 'assets/images/default_avatar.png',
      username: map['username'] ?? '',
      location: map['location'],
    );
  }
} 
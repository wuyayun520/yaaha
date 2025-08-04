class Ride {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String rider;
  final String distance;
  final String duration;
  final DateTime createdAt;
  final List<String> tags;
  final double rating;
  final int likes;
  final String route;
  final String motorcycleModel;
  final String weather;
  final String difficulty;

  const Ride({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rider,
    required this.distance,
    required this.duration,
    required this.createdAt,
    required this.tags,
    required this.rating,
    required this.likes,
    required this.route,
    required this.motorcycleModel,
    required this.weather,
    required this.difficulty,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rider: json['rider'] as String,
      distance: json['distance'] as String,
      duration: json['duration'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      tags: List<String>.from(json['tags'] as List),
      rating: (json['rating'] as num).toDouble(),
      likes: json['likes'] as int,
      route: json['route'] as String,
      motorcycleModel: json['motorcycleModel'] as String,
      weather: json['weather'] as String,
      difficulty: json['difficulty'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'rider': rider,
      'distance': distance,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'tags': tags,
      'rating': rating,
      'likes': likes,
      'route': route,
      'motorcycleModel': motorcycleModel,
      'weather': weather,
      'difficulty': difficulty,
    };
  }

  Ride copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? rider,
    String? distance,
    String? duration,
    DateTime? createdAt,
    List<String>? tags,
    double? rating,
    int? likes,
    String? route,
    String? motorcycleModel,
    String? weather,
    String? difficulty,
  }) {
    return Ride(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rider: rider ?? this.rider,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      likes: likes ?? this.likes,
      route: route ?? this.route,
      motorcycleModel: motorcycleModel ?? this.motorcycleModel,
      weather: weather ?? this.weather,
      difficulty: difficulty ?? this.difficulty,
    );
  }
} 
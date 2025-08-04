import '../models/ride.dart';

class RideService {
  static final List<Ride> _sampleRides = [
    Ride(
      id: '1',
      title: 'Mountain Pass Adventure',
      description: 'Epic ride through the scenic mountain roads with breathtaking views and challenging curves.',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      rider: 'Alex Rider',
      distance: '150 km',
      duration: '3 hours',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      tags: ['Mountain', 'Scenic', 'Challenging'],
      rating: 4.8,
      likes: 156,
      route: 'Mountain Highway Route',
      motorcycleModel: 'Honda CBR600RR',
      weather: 'Sunny',
      difficulty: 'Intermediate',
    ),
    Ride(
      id: '2',
      title: 'Coastal Highway Cruise',
      description: 'Beautiful coastal route with ocean views and smooth roads perfect for cruising.',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=400',
      rider: 'Sarah Speed',
      distance: '85 km',
      duration: '2 hours',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      tags: ['Coastal', 'Scenic', 'Relaxing'],
      rating: 4.6,
      likes: 89,
      route: 'Coastal Highway',
      motorcycleModel: 'Yamaha R1',
      weather: 'Partly Cloudy',
      difficulty: 'Easy',
    ),
    Ride(
      id: '3',
      title: 'City Night Tour',
      description: 'Urban exploration under city lights with vibrant nightlife and smooth city roads.',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      rider: 'Mike Motor',
      distance: '45 km',
      duration: '1.5 hours',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      tags: ['Urban', 'Night', 'City'],
      rating: 4.4,
      likes: 67,
      route: 'City Center Loop',
      motorcycleModel: 'Kawasaki Ninja 650',
      weather: 'Clear',
      difficulty: 'Easy',
    ),
    Ride(
      id: '4',
      title: 'Forest Trail Discovery',
      description: 'Off-road adventure through dense forests with challenging terrain and natural obstacles.',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=400',
      rider: 'Emma Explorer',
      distance: '120 km',
      duration: '4 hours',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      tags: ['Off-road', 'Forest', 'Adventure'],
      rating: 4.9,
      likes: 234,
      route: 'Forest Trail Network',
      motorcycleModel: 'KTM 450 EXC',
      weather: 'Overcast',
      difficulty: 'Hard',
    ),
    Ride(
      id: '5',
      title: 'Desert Highway Run',
      description: 'Long distance ride across desert landscapes with endless horizons and open roads.',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      rider: 'David Desert',
      distance: '300 km',
      duration: '6 hours',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      tags: ['Desert', 'Long Distance', 'Endurance'],
      rating: 4.7,
      likes: 189,
      route: 'Desert Highway',
      motorcycleModel: 'BMW R1250GS',
      weather: 'Hot',
      difficulty: 'Intermediate',
    ),
    Ride(
      id: '6',
      title: 'Riverside Route',
      description: 'Peaceful ride along the river banks with gentle curves and beautiful water views.',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=400',
      rider: 'Lisa Lakes',
      distance: '75 km',
      duration: '2.5 hours',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      tags: ['Riverside', 'Peaceful', 'Scenic'],
      rating: 4.5,
      likes: 112,
      route: 'Riverside Path',
      motorcycleModel: 'Ducati Monster 821',
      weather: 'Mild',
      difficulty: 'Easy',
    ),
  ];

  static List<Ride> getFeaturedRides() {
    return _sampleRides.take(3).toList();
  }

  static List<Ride> getRecentRides() {
    return _sampleRides.skip(3).toList();
  }

  static List<Ride> getAllRides() {
    return List.from(_sampleRides);
  }

  static Ride? getRideById(String id) {
    try {
      return _sampleRides.firstWhere((ride) => ride.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Ride> searchRides(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _sampleRides.where((ride) {
      return ride.title.toLowerCase().contains(lowercaseQuery) ||
             ride.description.toLowerCase().contains(lowercaseQuery) ||
             ride.rider.toLowerCase().contains(lowercaseQuery) ||
             ride.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  static List<Ride> getRidesByDifficulty(String difficulty) {
    return _sampleRides.where((ride) => ride.difficulty == difficulty).toList();
  }

  static List<Ride> getRidesByTag(String tag) {
    return _sampleRides.where((ride) => ride.tags.contains(tag)).toList();
  }
} 
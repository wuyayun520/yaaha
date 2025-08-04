import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

import 'activity_detail_screen.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  List<Map<String, dynamic>> _events = [];
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load events data
      final String eventsResponse = await rootBundle.loadString('assets/activaty/motorcycle_events.json');
      final eventsData = await json.decode(eventsResponse);
      
      // Load users data
      final String usersResponse = await rootBundle.loadString('assets/post/motorcycle_users.json');
      final usersData = await json.decode(usersResponse);
      
      setState(() {
        _events = List<Map<String, dynamic>>.from(eventsData['motorcycle_events']);
        _users = List<Map<String, dynamic>>.from(usersData['users']);
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Get random user avatars for participants
  List<String> _getRandomUserAvatars(int count) {
    if (_users.isEmpty) return [];
    
    final List<String> avatars = [];
    final List<int> usedIndices = [];
    
    for (int i = 0; i < count && i < _users.length; i++) {
      int randomIndex;
      do {
        randomIndex = _random.nextInt(_users.length);
      } while (usedIndices.contains(randomIndex));
      
      usedIndices.add(randomIndex);
      avatars.add(_users[randomIndex]['profile_image'] as String);
    }
    
    return avatars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text(
          'Activities',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF222222),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF222222)),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.blue, width: 1),
                  right: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  final participantCount = event['participants'] as int;
                  final avatars = _getRandomUserAvatars(4); // Get 4 random avatars
                  
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityDetailScreen(
                            event: event,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Event Image and Details Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Event Image
                              Container(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(event['image_reference'] as String),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              
                              // Event Details
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Event Title
                                      Text(
                                        event['event_name'] as String,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      
                                      // Activity Type Tag
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.eco,
                                              size: 12,
                                              color: Colors.green.shade700,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              event['activity_type'] as String,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      
                                      // Date and Time
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${_formatDate(event['date'] as String)} ${event['time'] as String}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      
                                      // Distance/Location
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            event['route_distance'] as String,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Followers Section and Action Button Row
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Followers Section
                                Row(
                                  children: [
                                    // Avatar Stack with real user images
                                    SizedBox(
                                      width: 80,
                                      height: 24,
                                      child: Stack(
                                        children: [
                                          for (int i = 0; i < avatars.length; i++)
                                            Positioned(
                                              left: i * 20.0,
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    avatars[i],
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.grey.shade300,
                                                        ),
                                                        child: const Icon(
                                                          Icons.person,
                                                          size: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$participantCount followers',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // Action Button
                                ElevatedButton(
                                  onPressed: () {
                                    _handleRideNow(event);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF222222),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    elevation: 2,
                                    minimumSize: const Size(80, 32),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.motorcycle,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Ride Now',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  String _formatDate(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      final month = dateTime.month.toString().padLeft(2, '0');
      final day = dateTime.day.toString().padLeft(2, '0');
      return '$month-$day';
    } catch (e) {
      return date;
    }
  }

  void _handleRideNow(Map<String, dynamic> event) {
    // TODO: Implement ride now functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joining ${event['event_name']}...'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
} 
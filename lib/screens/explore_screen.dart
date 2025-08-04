import 'package:flutter/material.dart';
import '../widgets/user_card.dart';
import '../widgets/post_card.dart';
import '../services/user_service.dart';
import '../services/report_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _allPosts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await UserService.loadUsers();
    final users = UserService.getAllUsers();

    // Extract all posts from users
    final allPosts = <Map<String, dynamic>>[];
    for (final user in users) {
      if (user['posts'] != null) {
        for (final post in user['posts'] as List<dynamic>) {
          allPosts.add({
            ...post as Map<String, dynamic>,
            'user': user,
          });
        }
      }
    }

    // Filter out reported posts
    final reportedPosts = await ReportService.getReportedPosts();
    final filteredPosts = allPosts.where((post) {
      final postId = post['id'].toString();
      return !reportedPosts.contains(postId);
    }).toList();

    setState(() {
      _users = users;
      _allPosts = filteredPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Column(
        children: [
          // Status bar spacing
          SizedBox(height: MediaQuery.of(context).padding.top),
          
          // Users Horizontal List
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: UserCard(user: _users[index]),
                );
              },
            ),
          ),
          
          // Posts Waterfall Layout
          if (_allPosts.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildWaterfallLayout(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWaterfallLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 8) / 2; // 8px spacing between columns
        
        // Create two columns
        final leftColumn = <Widget>[];
        final rightColumn = <Widget>[];
        
        // Distribute posts between columns
        for (int i = 0; i < _allPosts.length; i++) {
          final post = _allPosts[i];
          final user = post['user'] as Map<String, dynamic>;
          final postCard = PostCard(
            post: post,
            user: user,
          );
          
          // Alternate between left and right columns
          if (i % 2 == 0) {
            leftColumn.add(postCard);
          } else {
            rightColumn.add(postCard);
          }
        }
        
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              child: Column(
                children: leftColumn.map((widget) => 
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: widget,
                  )
                ).toList(),
              ),
            ),
            const SizedBox(width: 8),
            // Right Column
            Expanded(
              child: Column(
                children: rightColumn.map((widget) => 
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: widget,
                  )
                ).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
} 
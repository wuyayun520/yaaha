import 'package:flutter/material.dart';
import '../services/report_service.dart';
import '../services/follow_service.dart';
import '../services/block_service.dart';
import 'post_detail_screen.dart';
import 'chat_page.dart';
import '../models/user_model.dart';
import 'package:flutter/services.dart';

class UserDetailScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  List<Map<String, dynamic>> _userPosts = [];
  bool _isFollowing = false;
  bool _isLoadingFollowStatus = true;
  bool _isUserBlocked = false;

  @override
  void initState() {
    super.initState();
    _loadUserPosts();
    _loadFollowStatus();
    _checkBlockStatus();
  }

  Future<void> _loadUserPosts() async {
    final reportedPosts = await ReportService.getReportedPosts();
    final posts = <Map<String, dynamic>>[];
    
    print('Loading posts for user: ${widget.user['username']}');
    print('User posts data: ${widget.user['posts']}');
    print('Reported posts: $reportedPosts');
    
    if (widget.user['posts'] != null) {
      for (final post in widget.user['posts'] as List<dynamic>) {
        final postId = post['id'].toString();
        print('Processing post ID: $postId');
        if (!reportedPosts.contains(postId)) {
          posts.add({
            ...post as Map<String, dynamic>,
            'user': widget.user,
          });
          print('Added post: $postId');
        } else {
          print('Post $postId is reported, skipping');
        }
      }
    } else {
      print('No posts found for user');
    }
    
    print('Final posts count: ${posts.length}');
    
    setState(() {
      _userPosts = posts;
    });
  }

  Future<void> _loadFollowStatus() async {
    try {
      final userId = widget.user['id'].toString();
      final isFollowing = await FollowService.isFollowingUser(userId);
      
      setState(() {
        _isFollowing = isFollowing;
        _isLoadingFollowStatus = false;
      });
    } catch (e) {
      print('Error loading follow status: $e');
      setState(() {
        _isLoadingFollowStatus = false;
      });
    }
  }

  Future<void> _checkBlockStatus() async {
    try {
      final userId = widget.user['id'].toString();
      final isBlocked = await BlockService.isUserBlocked(userId);
      
      setState(() {
        _isUserBlocked = isBlocked;
      });
    } catch (e) {
      print('Error checking block status: $e');
    }
  }

  Future<void> _toggleFollowStatus() async {
    try {
      final userId = widget.user['id'].toString();
      bool success = false;
      
      if (_isFollowing) {
        success = await FollowService.unfollowUser(userId);
        if (success) {
          setState(() {
            _isFollowing = false;
          });
          _showSnackBar('Unfollowed ${widget.user['username']}');
        }
      } else {
        success = await FollowService.followUser(userId);
        if (success) {
          setState(() {
            _isFollowing = true;
          });
          _showSnackBar('Followed ${widget.user['username']}');
        }
      }
      
      if (!success) {
        _showSnackBar('Operation failed, please try again');
      }
    } catch (e) {
      print('Error toggling follow status: $e');
      _showSnackBar('Operation failed, please try again');
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.block,
                color: Colors.red,
              ),
              title: Text(
                _isUserBlocked ? 'Unblock User' : 'Block User',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showBlockDialog();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.report,
                color: Colors.orange,
              ),
              title: const Text(
                'Report User',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showReportDialog();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          _isUserBlocked ? 'Unblock User' : 'Block User',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          _isUserBlocked
              ? 'Are you sure you want to unblock ${widget.user['username']}?'
              : 'Are you sure you want to block ${widget.user['username']}? You won\'t see their content anymore.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handleBlockAction();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(_isUserBlocked ? 'Unblock' : 'Block'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Report User',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to report this user? This action will be reviewed by our team.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handleReportAction();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.orange,
            ),
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleBlockAction() async {
    try {
      final userId = widget.user['id'].toString();
      bool success = false;
      
      if (_isUserBlocked) {
        success = await BlockService.unblockUser(userId);
        if (success) {
          setState(() {
            _isUserBlocked = false;
          });
          _showSnackBar('Unblocked ${widget.user['username']}');
        }
      } else {
        success = await BlockService.blockUser(userId);
        if (success) {
          setState(() {
            _isUserBlocked = true;
          });
          _showSnackBar('Blocked ${widget.user['username']}');
          // 延迟返回上一页，让用户看到提示信息
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pop(context);
            }
          });
        }
      }
      
      if (!success) {
        _showSnackBar('Operation failed, please try again');
      }
    } catch (e) {
      print('Error handling block action: $e');
      _showSnackBar('Operation failed, please try again');
    }
  }

  Future<void> _handleReportAction() async {
    try {
      final userId = widget.user['id'].toString();
      final success = await ReportService.reportPost(userId); // 使用现有的举报服务
      
      if (success) {
        _showSnackBar('User reported successfully');
        // 延迟返回上一页
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } else {
        _showSnackBar('User already reported');
      }
    } catch (e) {
      print('Error reporting user: $e');
      _showSnackBar('Operation failed, please try again');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handleChatAction() {
    // 将用户数据转换为UserModel
    final userModel = UserModel.fromMap(widget.user);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(user: userModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Text(
          widget.user['username'] as String,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: _isUserBlocked
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'User Blocked',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'You have blocked this user.\nTheir content is hidden.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      _showBlockDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Unblock User'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  // Background Image Section with AppBar overlay
                  if (widget.user['background_image'] != null)
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.user['background_image'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                            stops: const [0.0, 0.3, 1.0],
                          ),
                        ),
                      ),
                    ),
                  
            // User Profile Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                        // Profile Image with Border
                  Container(
                          width: 120,
                          height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                      ),
                            ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.user['profile_image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                            ),
                            child: const Icon(
                              Icons.person,
                                    size: 60,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                        // User Name and Age
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                  Text(
                    widget.user['name'] as String,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                            ),
                            if (widget.user['age'] != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${widget.user['age']} years',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Username
                  Text(
                    '@${widget.user['username']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Location
                  if (widget.user['location'] != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.user['location'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  
                        const SizedBox(height: 20),
                        
                        // Bio Section
                        if (widget.user['bio'] != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.user['bio'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                            _buildStatItem(
                              'Posts',
                              _userPosts.length.toString(),
                              Icons.photo_library,
                            ),
                            _buildStatItem(
                              'Followers',
                              _formatNumber(widget.user['follower_count'] ?? 0),
                              Icons.people,
                            ),
                            _buildStatItem(
                              'Following',
                              _formatNumber(widget.user['following_count'] ?? 0),
                              Icons.person_add,
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Follow and Chat Buttons Row
                        Row(
                          children: [
                            // Follow Button
                            Expanded(
                              child: _isLoadingFollowStatus
                                  ? const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Color(0xFF222222),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: _toggleFollowStatus,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _isFollowing 
                                            ? Colors.grey.shade300 
                                            : const Color(0xFF222222),
                                        foregroundColor: _isFollowing 
                                            ? Colors.black87 
                                            : Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        elevation: _isFollowing ? 0 : 2,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            _isFollowing ? Icons.check : Icons.person_add,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _isFollowing ? 'Following' : 'Follow',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            
                            const SizedBox(width: 12),
                            
                            // Chat Button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _handleChatAction();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF222222),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                      color: Color(0xFF222222),
                                      width: 1,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.chat_bubble_outline,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Message',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Motorcycle Information Section
                  if (widget.user['bike_model'] != null || 
                      widget.user['riding_experience'] != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.motorcycle,
                                color: Color(0xFF222222),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Motorcycle Info',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          if (widget.user['bike_model'] != null)
                            _buildInfoRow(
                              'Bike Model',
                              widget.user['bike_model'] as String,
                              Icons.settings,
                            ),
                          
                          if (widget.user['riding_experience'] != null)
                            _buildInfoRow(
                              'Riding Experience',
                              widget.user['riding_experience'] as String,
                              Icons.timer,
                            ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 12),
                  
                  // Favorite Routes Section
                  if (widget.user['favorite_routes'] != null &&
                      (widget.user['favorite_routes'] as List).isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.route,
                                color: Color(0xFF222222),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Favorite Routes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: (widget.user['favorite_routes'] as List)
                                .map<Widget>((route) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        route as String,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ))
                                .toList(),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // User Posts Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.photo_library,
                              color: Color(0xFF222222),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                    const Text(
                      'Posts',
                      style: TextStyle(
                                fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _userPosts.length.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                    
                        if (_userPosts.isNotEmpty) ...[
                    // Posts Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                        childAspectRatio: 1,
                      ),
                      itemCount: _userPosts.length,
                      itemBuilder: (context, index) {
                        final post = _userPosts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  post: post,
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                              color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                            ),
                            child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                post['images']?.isNotEmpty == true 
                                    ? post['images'][0] as String 
                                              : _getDefaultImageForUser(widget.user['id'] as int),
                                fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                                        ),
                                        if (post['images']?.length > 1)
                                          Positioned(
                                            top: 3,
                                            right: 3,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 4,
                                                vertical: 1,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.7),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: const Icon(
                                                Icons.collections,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                        ] else ...[
                          // No posts message
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.photo_library_outlined,
                                  size: 50,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No posts yet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'This user hasn\'t shared any posts yet',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                  ],
                ),
              ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF222222),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  String _getDefaultImageForUser(int userId) {
    switch (userId) {
      case 1:
        return 'assets/post/1/pic_1.jpg';
      case 2:
        return 'assets/post/2/pic_1.jpg';
      case 3:
        return 'assets/post/3/pic_1.jpg';
      case 4:
        return 'assets/post/4/pic_1.jpg';
      case 5:
        return 'assets/post/5/pic_1.jpg';
      case 6:
        return 'assets/post/6/pic_1.jpg';
      case 7:
        return 'assets/post/7/pic_1.jpg';
      case 8:
        return 'assets/post/8/pic_1.jpg';
      case 9:
        return 'assets/post/9/pic_1.jpg';
      case 10:
        return 'assets/post/10/pic_1.jpg';
      case 11:
        return 'assets/post/11/pic_1.jpg';
      case 12:
        return 'assets/post/12/pic_1.jpg';
      case 13:
        return 'assets/post/13/pic_1.jpg';
      case 14:
        return 'assets/post/14/pic_1.jpg';
      case 15:
        return 'assets/post/15/pic_1.jpg';
      default:
        return 'assets/post/1/pic_1.jpg';
    }
  }
} 
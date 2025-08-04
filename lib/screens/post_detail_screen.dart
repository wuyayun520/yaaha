import 'package:flutter/material.dart';
import '../services/like_service.dart';
import '../services/report_service.dart';

class PostDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  final Map<String, dynamic> user;

  const PostDetailScreen({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _loadLikeState();
  }

  Future<void> _loadLikeState() async {
    final postId = widget.post['id'].toString();
    final likeState = await LikeService.getLikeState(postId);
    final savedLikeCount = await LikeService.getLikeCount(postId);
    
    // Use the likes from JSON data as initial count, or saved count if available
    final initialLikeCount = widget.post['likes'] ?? 0;
    final currentLikeCount = savedLikeCount > 0 ? savedLikeCount : initialLikeCount;
    
    setState(() {
      _isLiked = likeState;
      _likeCount = currentLikeCount;
    });
  }

  Future<void> _toggleLike() async {
    final postId = widget.post['id'].toString();
    final newLikeState = !_isLiked;
    
    await LikeService.setLikeState(postId, newLikeState);
    await LikeService.setLikeCount(postId, newLikeState ? _likeCount + 1 : _likeCount - 1);
    
    setState(() {
      _isLiked = newLikeState;
      _likeCount = newLikeState ? _likeCount + 1 : _likeCount - 1;
    });
  }

  Future<void> _reportPost() async {
    final postId = widget.post['id'].toString();
    
    // Show report options dialog
    final reportReason = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please select a reason for reporting this post:',
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              // Report options
              GestureDetector(
                onTap: () => Navigator.of(context).pop('Inappropriate Content'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    'Inappropriate Content',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop('Spam'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    'Spam',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop('Harassment'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    'Harassment',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop('Violence'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    'Violence',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop('Other'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    'Other',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (reportReason != null) {
      final success = await ReportService.reportPost(postId);
      
      if (success) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Post reported for: $reportReason'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          
          // Navigate back to previous screen
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post already reported'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void _showImagePreview(BuildContext context, String imagePath, int initialIndex, List<String> images) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        foregroundColor: Colors.white,
        title: Text(
          'Post Details',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Report Button
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: ElevatedButton.icon(
              onPressed: _reportPost,
              label: const Text('Report', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  // Main Image
                  GestureDetector(
                    onTap: () {
                      if (widget.post['images'] != null && (widget.post['images'] as List).isNotEmpty) {
                        _showImagePreview(context, widget.post['images'][0], 0, List<String>.from(widget.post['images']));
                      }
                    },
                    child: Image.asset(
                      widget.post['images']?.isNotEmpty == true 
                          ? widget.post['images'][0] as String 
                          : 'assets/post/1/pic_1.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.image,
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  // Like Button - Top Right
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: _toggleLike,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 20,
                              color: _isLiked ? Colors.red : Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$_likeCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Content
                  if (widget.post['content'] != null)
                    Text(
                      widget.post['content'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Hashtags
                  if (widget.post['hashtags'] != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (widget.post['hashtags'] as List<dynamic>)
                          .map((hashtag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  hashtag as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // User Info
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
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
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user['name'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              widget.user['location'] ?? 'Unknown Location',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Additional Images Section
            if (widget.post['images'] != null && (widget.post['images'] as List).length > 1)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'More Photos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (widget.post['images'] as List).length - 1,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _showImagePreview(context, widget.post['images'][index + 1], index + 1, List<String>.from(widget.post['images']));
                            },
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade100,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  widget.post['images'][index + 1] as String,
                                  fit: BoxFit.cover,
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
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ImagePreviewScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImagePreviewScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            child: Center(
              child: Image.asset(
                widget.images[index],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade800,
                    child: const Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
} 
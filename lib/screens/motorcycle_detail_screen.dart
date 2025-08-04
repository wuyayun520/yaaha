import 'package:flutter/material.dart';
import '../services/favorite_service.dart';

class MotorcycleDetailScreen extends StatefulWidget {
  final Map<String, dynamic> motorcycle;

  const MotorcycleDetailScreen({
    super.key,
    required this.motorcycle,
  });

  @override
  State<MotorcycleDetailScreen> createState() => _MotorcycleDetailScreenState();
}

class _MotorcycleDetailScreenState extends State<MotorcycleDetailScreen> {
  bool _isFavorite = false;
  bool _isLoadingFavorite = true;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      final isFavorite = await FavoriteService.isFavorite(widget.motorcycle);
      setState(() {
        _isFavorite = isFavorite;
        _isLoadingFavorite = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingFavorite = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      bool success;
      if (_isFavorite) {
        success = await FavoriteService.removeFavorite(widget.motorcycle);
        if (success) {
          setState(() {
            _isFavorite = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Removed from favorites')),
            );
          }
        }
      } else {
        success = await FavoriteService.addFavorite(widget.motorcycle);
        if (success) {
          setState(() {
            _isFavorite = true;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added to favorites')),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Already in favorites')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update favorites')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final basicInfo = widget.motorcycle['basic_info'] as Map<String, dynamic>;
    final technicalSpecs = widget.motorcycle['technical_specs'] as Map<String, dynamic>;
    final performanceFeatures = widget.motorcycle['performance_features'] as Map<String, dynamic>;
    final designFeatures = widget.motorcycle['design_features'] as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        foregroundColor: Colors.white,
        title: Text(
          '${basicInfo['brand']} ${basicInfo['model']}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          // Favorite Button
          if (!_isLoadingFavorite)
            IconButton(
              onPressed: _toggleFavorite,
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.white,
                size: 24,
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                widget.motorcycle['filename'] as String,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.motorcycle,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            // Basic Info Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    '${basicInfo['brand']} ${basicInfo['model']}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Category and Year
                  Text(
                    '${basicInfo['category']} • ${basicInfo['year_range']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Price
                  Text(
                    'Estimated Price: ${basicInfo['estimated_price']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Performance Specs Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Performance Specifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Performance Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildSpecCard(
                          'Top Speed',
                          performanceFeatures['top_speed'] ?? 'N/A',
                          Icons.speed,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpecCard(
                          'Acceleration',
                          performanceFeatures['acceleration'] ?? 'N/A',
                          Icons.timer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSpecCard(
                          'Weight',
                          performanceFeatures['weight'] ?? 'N/A',
                          Icons.fitness_center,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpecCard(
                          'Fuel Capacity',
                          performanceFeatures['fuel_capacity'] ?? 'N/A',
                          Icons.local_gas_station,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Technical Specs Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Technical Specifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildTechSpec('Engine Type', technicalSpecs['engine']['type'] ?? 'N/A'),
                  _buildTechSpec('Displacement', technicalSpecs['engine']['displacement'] ?? 'N/A'),
                  _buildTechSpec('Power', technicalSpecs['engine']['power'] ?? 'N/A'),
                  _buildTechSpec('Torque', technicalSpecs['engine']['torque'] ?? 'N/A'),
                  _buildTechSpec('Transmission', technicalSpecs['transmission'] ?? 'N/A'),
                  _buildTechSpec('Front Suspension', technicalSpecs['suspension']['front'] ?? 'N/A'),
                  _buildTechSpec('Rear Suspension', technicalSpecs['suspension']['rear'] ?? 'N/A'),
                  _buildTechSpec('Front Brakes', technicalSpecs['brakes']['front'] ?? 'N/A'),
                  _buildTechSpec('Rear Brakes', technicalSpecs['brakes']['rear'] ?? 'N/A'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Design Features Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Design Features',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  if (designFeatures['color_scheme'] != null)
                    _buildDesignFeature('Color Scheme', designFeatures['color_scheme']['primary'] ?? 'N/A'),
                  if (designFeatures['exhaust'] != null)
                    _buildDesignFeature('Exhaust', designFeatures['exhaust']['type'] ?? 'N/A'),
                  if (designFeatures['fairing'] != null)
                    _buildDesignFeature('Fairing', designFeatures['fairing'].toString()),
                  if (designFeatures['seat'] != null)
                    _buildDesignFeature('Seat', designFeatures['seat']['rider'] ?? 'N/A'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Description Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    widget.motorcycle['description'] ?? 'No description available.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
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

  Widget _buildSpecCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: const Color(0xFF222222),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTechSpec(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignFeature(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
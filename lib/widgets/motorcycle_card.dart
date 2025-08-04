import 'package:flutter/material.dart';
import '../screens/motorcycle_detail_screen.dart';

class MotorcycleCard extends StatelessWidget {
  final Map<String, dynamic> motorcycle;

  const MotorcycleCard({
    super.key,
    required this.motorcycle,
  });

  @override
  Widget build(BuildContext context) {
    final basicInfo = motorcycle['basic_info'] as Map<String, dynamic>;
    final technicalSpecs = motorcycle['technical_specs'] as Map<String, dynamic>;
    final performanceFeatures = motorcycle['performance_features'] as Map<String, dynamic>;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MotorcycleDetailScreen(
              motorcycle: motorcycle,
            ),
          ),
        );
      },
      child: Container(
        width: 280,
        height: 280,
        margin: const EdgeInsets.only(right: 16),
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
            // Header with brand/model and favorite button
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${basicInfo['brand']} ${basicInfo['model']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${performanceFeatures['weight']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            // Motorcycle Image
            Container(
              height: 130,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  motorcycle['filename'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.motorcycle,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Footer with specs - Two rows layout
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // First row: Power and V-max
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Power
                      Column(
                        children: [
                          const Text(
                            'Power',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            technicalSpecs['engine']['displacement'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      // V-max
                      Column(
                        children: [
                          const Text(
                            'V-max',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            performanceFeatures['top_speed'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 6),
                  
                  // Second row: Brand logo and name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.motorcycle,
                          size: 9,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        basicInfo['brand'] ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
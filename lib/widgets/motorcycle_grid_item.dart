import 'package:flutter/material.dart';
import '../screens/motorcycle_detail_screen.dart';

class MotorcycleGridItem extends StatelessWidget {
  final Map<String, dynamic> motorcycle;

  const MotorcycleGridItem({
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Motorcycle Image
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: Colors.grey.shade100,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(
                  motorcycle['filename'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.motorcycle,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand and Model
                  Text(
                    '${basicInfo['brand']} ${basicInfo['model']}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Weight
                  Text(
                    '${performanceFeatures['weight']}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Specs row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Power
                      Column(
                        children: [
                          const Text(
                            'Power',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            technicalSpecs['engine']['displacement'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 9,
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
                              fontSize: 8,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            performanceFeatures['top_speed'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
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
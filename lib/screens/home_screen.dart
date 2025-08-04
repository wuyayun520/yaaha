import 'package:flutter/material.dart';
import '../widgets/motorcycle_card.dart';
import '../widgets/motorcycle_grid_item.dart';
import '../services/motorcycle_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _motorcycles = [];
  List<Map<String, dynamic>> _remainingMotorcycles = [];

  @override
  void initState() {
    super.initState();
    _loadMotorcycles();
  }

  Future<void> _loadMotorcycles() async {
    await MotorcycleService.loadMotorcycles();
    final allMotorcycles = MotorcycleService.getAllMotorcycles();
    final randomMotorcycles = MotorcycleService.getRandomMotorcycles(5);
    
    // Get remaining motorcycles (excluding the 5 random ones)
    final remainingMotorcycles = allMotorcycles.where((moto) => 
      !randomMotorcycles.any((random) => random['id'] == moto['id'])
    ).toList();
    
    setState(() {
      _motorcycles = randomMotorcycles;
      _remainingMotorcycles = remainingMotorcycles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Image with status bar padding
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Image.asset(
                'assets/images/yaaha_home_banner.png',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: const Color(0xFF2A2A2A),
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            // TOP MODELS Image
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 20.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/yaaha_home_topmooels.png',
                  height: 30,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 30,
                      color: Colors.black,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'TOP MODELS',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Motorcycle Carousel
            if (_motorcycles.isNotEmpty)
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: _motorcycles.length,
                  itemBuilder: (context, index) {
                    return MotorcycleCard(
                      motorcycle: _motorcycles[index],
                    );
                  },
                ),
              ),
            // RECOMMEND Image
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 20.0, bottom: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/yaaha_home_recommend.png',
                  height: 30,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 30,
                      color: Colors.black,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RECOMMEND',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Grid of remaining motorcycles
            if (_remainingMotorcycles.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _remainingMotorcycles.length,
                  itemBuilder: (context, index) {
                    return MotorcycleGridItem(
                      motorcycle: _remainingMotorcycles[index],
                    );
                  },
                ),
              ),
            // Bottom padding for scroll
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
} 
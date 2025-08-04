import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF222222),
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                selectedIndex == 0 
                    ? 'assets/images/tab_2/yaaha_tab_1_pre.png'
                    : 'assets/images/tab_1/yaaha_tab_1_nor.png',
                width: 32,
                height: 32,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                selectedIndex == 1 
                    ? 'assets/images/tab_2/yaaha_tab_2_pre.png'
                    : 'assets/images/tab_1/yaaha_tab_2_nor.png',
                width: 32,
                height: 32,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                selectedIndex == 2 
                    ? 'assets/images/tab_2/yaaha_tab_3_pre.png'
                    : 'assets/images/tab_1/yaaha_tab_3_nor.png',
                width: 32,
                height: 32,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                selectedIndex == 3 
                    ? 'assets/images/tab_2/yaaha_tab_4_pre.png'
                    : 'assets/images/tab_1/yaaha_tab_4_nor.png',
                width: 32,
                height: 32,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
} 
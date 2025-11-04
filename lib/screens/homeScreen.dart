import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/screens/moodScreen.dart';
import 'package:evencir_task/screens/nutritionScreen.dart';
import 'package:evencir_task/screens/planScreen.dart';
import 'package:evencir_task/screens/profileScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NutritionScreen(),
    PlanScreen(),
    Moodscreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 12, height: 1.8),
        unselectedLabelStyle: const TextStyle(fontSize: 12, height: 1.8),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: NavIcon(AppImages.nutritionIcon, 0),
            label: "Nutrition",
          ),
          BottomNavigationBarItem(
            icon: NavIcon(AppImages.planIcon, 1),
            label: "Plan",
          ),
          BottomNavigationBarItem(
            icon: NavIcon(AppImages.moodIcon, 2),
            label: "Mood",
          ),
          BottomNavigationBarItem(
            icon: NavIcon(AppImages.profileIcon, 3),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget NavIcon(String assetPath, int index) {
    final bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Image.asset(
        assetPath,
        width: 26,
        height: 26,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }
}

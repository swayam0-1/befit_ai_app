import 'package:befit_ai_app/view/Screens/home_content.dart';
import 'package:flutter/material.dart';
import 'package:befit_ai_app/view/Screens/mental_wellness_screen.dart';
import 'package:befit_ai_app/view/Screens/nutrition_screen.dart';
import 'package:befit_ai_app/view/Screens/workout_screen.dart';
import 'package:befit_ai_app/view/Screens/news_screen.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current index of the bottom navigation bar


  final List<Widget> _screens = [
    HomeContent(), // Home content
    WorkoutScreen(),
    NutritionPage(),
    MentalWellnessScreen(),
    NewsScreen(), // Add your NewsScreen here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_currentIndex], // Display the selected screen

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex, // Current index state
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Nutrition'),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: 'Wellness'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index
          });
        },
      ),
    );
  }
}




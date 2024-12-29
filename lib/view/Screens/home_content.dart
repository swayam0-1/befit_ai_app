import 'package:befit_ai_app/controller/auth_controller.dart';
import 'package:befit_ai_app/view/Screens/exercise/workout_onboard.dart';
import 'package:befit_ai_app/view/Screens/mental_wellness_screen.dart';
import 'package:befit_ai_app/view/Screens/workout_screen.dart';
import 'package:befit_ai_app/view/widgets/featured_workout_card.dart';
import 'package:befit_ai_app/view/widgets/overview_card.dart';
import 'package:flutter/material.dart';

import '../widgets/quick_action_button.dart';
import 'nutrition_screen.dart';
class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  AuthController _authController=AuthController();
  String? _username;
  @override
  void initState(){
    super.initState();
    _loadUsername();
  }
  Future<void> _loadUsername()async{
    String? username = await _authController.fetchUsername();
    setState(() {
      _username=username;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                style: TextStyle(color: Colors.black, fontSize: 18),
                'Hi! welcome $_username'

            ),
            Icon(Icons.person, color: Colors.black, size: 28),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Overview Cards (Horizontal Scrollable)
            Container(
              height: 140,
              margin: EdgeInsets.only(top: 10, left: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  OverviewCard(
                    title: 'Workout',
                    subtitle: '45 min | Progress: 60%',
                    color: Colors.orangeAccent,
                    width: screenWidth * 0.8,
                  ),
                  OverviewCard(
                    title: 'Nutrition',
                    subtitle: '1200/2000 Cal | Protein 30g',
                    color: Colors.greenAccent,
                    width: screenWidth * 0.8,
                  ),
                  OverviewCard(
                    title: 'Mental Wellness',
                    subtitle: 'Completed Meditation',
                    color: Colors.lightBlueAccent,
                    width: screenWidth * 0.8,
                  ),
                ],
              ),
            ),
            // Key Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuickActionButton(
                    destination:  Workout(),
                    label: 'Start Workout',
                    icon: Icons.play_arrow,
                    color: Colors.redAccent,
                  ),
                  QuickActionButton(
                    destination: NutritionPage(),
                    label: 'Log Meal',
                    icon: Icons.fastfood,
                    color: Colors.orangeAccent,
                  ),
                 const QuickActionButton(
                    destination: MentalWellnessScreen(),
                    label: 'Start Meditation',
                    icon: Icons.spa,
                    color: Colors.lightBlueAccent,
                  ),
                ],
              ),
            ),
            // Featured Workouts / Challenges
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Featured Workouts & Challenges',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FeaturedWorkoutCard(width: screenWidth * 0.8, title: 'Full Body Workout'),
                  FeaturedWorkoutCard(width: screenWidth * 0.8, title: 'Cardio Session'),
                  FeaturedWorkoutCard(width: screenWidth * 0.8, title: 'Yoga'),
                ],
              ),
            ),
            // Mental Fitness Feature
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mental Fitness Feature',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Daily Affirmation: "You Got This!"'),
                  Row(
                    children: [
                      Text('Mood Tracker: '),
                      Icon(Icons.sentiment_satisfied, color: Colors.green),
                      Icon(Icons.sentiment_neutral, color: Colors.amber),
                      Icon(Icons.sentiment_dissatisfied, color: Colors.red),
                    ],
                  ),
                ],
              ),
            ),
            // Progress and Insights
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress & Insights',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ProgressCard(
                    title: 'Workout Progress Graph',
                    progressValue: 0.8,
                    color: Colors.orangeAccent,
                  ),
                  ProgressCard(
                    title: 'Nutrition Breakdown',
                    progressValue: 0.6,
                    color: Colors.greenAccent,
                  ),
                  ProgressCard(
                    title: 'Mood Tracker Graph',
                    progressValue: 0.7,
                    color: Colors.lightBlueAccent,
                  ),
                ],
              ),
            ),
            // Notifications
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Reminder: Log your workout today!'),
                    Icon(Icons.notifications, color: Colors.redAccent),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
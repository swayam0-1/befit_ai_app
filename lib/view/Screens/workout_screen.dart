import 'package:flutter/material.dart';
class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  String selectedCategory = '';
  String selectedExercise = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Categories'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workout Categories
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select a Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          WorkoutCategorySelector(
            categories: ['Full Body', 'Upper Body', 'Lower Body', 'Cardio'],
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
                selectedExercise = ''; // Reset the exercise on category change
              });
            },
            selectedCategory: selectedCategory,
            screenWidth: screenWidth,
          ),
          // Workout List (based on selected category)
          if (selectedCategory.isNotEmpty)
            WorkoutList(
              category: selectedCategory,
              onExerciseSelected: (exercise) {
                setState(() {
                  selectedExercise = exercise;
                });
              },
            ),
          // Start Workout Button (if an exercise is selected)
          if (selectedExercise.isNotEmpty)
            StartWorkoutSection(
              selectedExercise: selectedExercise,
              onStartWorkout: () {
                // Navigate to Pose Detection Screen if the exercise supports AI
                if (['Squats', 'Push-ups', 'Lunges'].contains(selectedExercise)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PoseDetectionScreen(exercise: selectedExercise)),
                  );
                }
              },
            ),
          // Workout Log Button
          WorkoutLogButton(),
        ],
      ),

    );
  }
}


class WorkoutCategorySelector extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;
  final String selectedCategory;
  final double screenWidth;

  WorkoutCategorySelector({
    required this.categories,
    required this.onCategorySelected,
    required this.selectedCategory,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories[index];
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              width: screenWidth * 0.4,
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selectedCategory == category ? Colors.orangeAccent : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: selectedCategory == category ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Workout List based on selected category
class WorkoutList extends StatelessWidget {
  final String category;
  final Function(String) onExerciseSelected;

  WorkoutList({required this.category, required this.onExerciseSelected});

  @override
  Widget build(BuildContext context) {
    final exercises = _getExercisesForCategory(category);
    return Expanded(
      child: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          String exercise = exercises[index];
          return ListTile(
            title: Text(exercise),
            onTap: () => onExerciseSelected(exercise),
          );
        },
      ),
    );
  }

  List<String> _getExercisesForCategory(String category) {
    switch (category) {
      case 'Full Body':
        return ['Squats (with AI)', 'Push-Ups', 'Jumping Jacks'];
      case 'Upper Body':
        return ['Push-Ups', 'Pull-Ups', 'Shoulder Press'];
      case 'Lower Body':
        return ['Squats (with AI)', 'Lunges (with AI)', 'Leg Raises'];
      case 'Cardio':
        return ['Jumping Jacks', 'Burpees', 'Mountain Climbers'];
      default:
        return [];
    }
  }
}

// Start Workout Section
class StartWorkoutSection extends StatelessWidget {
  final String selectedExercise;
  final Function onStartWorkout;

  StartWorkoutSection({required this.selectedExercise, required this.onStartWorkout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: ElevatedButton(
        onPressed: () => onStartWorkout(),
        child: Text('Start $selectedExercise'),
        style: ElevatedButton.styleFrom(
          backgroundColor: ['Squats', 'Push-ups', 'Lunges'].contains(selectedExercise)
              ? Colors.orangeAccent // AI-supported exercises
              : Colors.blueAccent, // Non-AI exercises
        ),
      ),
    );
  }
}

// Pose Detection Screen (with Camera Integration)
class PoseDetectionScreen extends StatelessWidget {
  final String exercise;

  PoseDetectionScreen({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$exercise Pose Detection'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Camera Feed
            Container(
              height: 300,
              width: 300,
              color: Colors.grey.shade300,
              child: Center(child: Text('Live Camera Feed')),
            ),
            SizedBox(height: 20),
            // Placeholder for Overlay Skeleton & Real-Time Feedback
            Text(
              'Real-Time Feedback: Lower your hips!',
              style: TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the workout screen
              },
              child: Text('End Workout'),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for Workout Log Button
class WorkoutLogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to workout log screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutLogScreen()));
        },
        child: Text('View Workout Log'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}

// Workout Log Screen
class WorkoutLogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History'),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text('Workout: Push-Ups'),
            subtitle: Text('Duration: 10 mins'),
          ),
          ListTile(
            title: Text('Workout: Squats'),
            subtitle: Text('Reps: 15 | AI Feedback: Good'),
          ),
        ],
      ),
    );
  }
}
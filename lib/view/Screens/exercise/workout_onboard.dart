import 'package:flutter/material.dart';
import 'dart:async'; // For using Timer


class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  // List of exercises (with image and title)
  final List<Map<String, String>> exercises = [
    {"name": "Push-Up", "image": "assets/push_up.png", "title": "Chest Strength"},
    {"name": "Squat", "image": "assets/squat.png", "title": "Leg Strength"},
    {"name": "Pull-Up", "image": "assets/pull_up.png", "title": "Back Strength"},
    {"name": "Crunch", "image": "assets/crunch.png", "title": "Core Strength"},
    {"name": "Lunges", "image": "assets/lunges.png", "title": "Leg Toning"},
    {"name": "Plank", "image": "assets/plank.png", "title": "Core Stability"},
    {"name": "Bicep Curl", "image": "assets/bicep_curl.png", "title": "Arm Strength"},
    {"name": "Deadlift", "image": "assets/deadlift.png", "title": "Full Body Strength"},
    {"name": "Mountain Climbers", "image": "assets/mountain_climbers.png", "title": "Cardio Strength"},
    {"name": "Dips", "image": "assets/dips.png", "title": "Triceps Toning"},
    {"name": "Burpees", "image": "assets/burpees.png", "title": "Full Body Workout"},
    {"name": "Leg Raises", "image": "assets/leg_raises.png", "title": "Core and Lower Abs"},
    {"name": "Jumping Jacks", "image": "assets/jumping_jacks.png", "title": "Cardio Endurance"},
    {"name": "Russian Twists", "image": "assets/russian_twists.png", "title": "Obliques Toning"},
    {"name": "High Knees", "image": "assets/high_knees.png", "title": "Cardio"},
    {"name": "Lateral Raises", "image": "assets/lateral_raises.png", "title": "Shoulder Strength"},
    {"name": "Triceps Kickback", "image": "assets/triceps_kickback.png", "title": "Arm Toning"},
    {"name": "Side Plank", "image": "assets/side_plank.png", "title": "Core and Stability"},
    {"name": "Leg Press", "image": "assets/leg_press.png", "title": "Leg Power"},
    {"name": "Step Ups", "image": "assets/step_ups.png", "title": "Leg and Cardio"}
  ];

  // This list tracks whether a card is selected or not
  List<bool> selectedExercises = List.generate(20, (index) => false);

  // Checks if any exercise is selected
  bool get anyExerciseSelected => selectedExercises.contains(true);

  // Function to navigate to the workout start screen
  void startWorkout() {
    List<Map<String, String>> selectedExercisesList = [];
    for (int i = 0; i < selectedExercises.length; i++) {
      if (selectedExercises[i]) {
        selectedExercisesList.add(exercises[i]);
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutStartScreen(selectedExercises: selectedExercisesList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Exercises'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,  // Two items per row
              crossAxisSpacing: 16.0,  // Space between columns
              mainAxisSpacing: 16.0,  // Space between rows
              childAspectRatio: 0.75,  // Aspect ratio for each card
            ),
            itemCount: exercises.length,
            shrinkWrap: true,  // To make the grid fit the content
            physics: NeverScrollableScrollPhysics(), // Disable grid scrolling
            itemBuilder: (context, index) {
              return ExerciseCard(
                name: exercises[index]['name']!,
                image: exercises[index]['image']!,
                title: exercises[index]['title']!,
                isSelected: selectedExercises[index],
                onTap: () {
                  setState(() {
                    selectedExercises[index] = !selectedExercises[index];
                  });
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: anyExerciseSelected,  // Only show the button when at least one exercise is selected
        child: FloatingActionButton(
          onPressed: startWorkout,
          backgroundColor: Colors.blue,
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String name;
  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ExerciseCard({
    required this.name,
    required this.image,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: isSelected
              ? BorderSide(color: Colors.blue, width: 2)
              : BorderSide.none, // Border when selected
        ),
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white, // Background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isSelected ? Colors.blue : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.blue : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutStartScreen extends StatefulWidget {
  final List<Map<String, String>> selectedExercises;

  WorkoutStartScreen({required this.selectedExercises});

  @override
  _WorkoutStartScreenState createState() => _WorkoutStartScreenState();
}

class _WorkoutStartScreenState extends State<WorkoutStartScreen> {
  // Timer related variables
  int _remainingTime = 30; // Set timer to 30 seconds for each exercise
  late Timer _timer;

  // Start the timer
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer when the screen loads
  }

  @override
  void dispose() {
    _timer.cancel(); // Clean up the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Start'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Perform the selected exercises below:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView.builder(
              itemCount: widget.selectedExercises.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedExercises[index]['name']!,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.selectedExercises[index]['title']!,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Time remaining: $_remainingTime seconds',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'api_service.dart';


class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  late Future<List<dynamic>> exercises;

  @override
  void initState() {
    super.initState();
    exercises = ApiService().fetchExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercises')),
      body: FutureBuilder<List<dynamic>>(
        future: exercises,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final exercise = snapshot.data![index];
                return ListTile(
                  title: Text(exercise['name']),
                  subtitle: Text(exercise['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}

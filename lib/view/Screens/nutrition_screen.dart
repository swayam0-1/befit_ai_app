import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Tracker'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: Container(
        color: Color(0xFFF8F5E1), // Background color
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Calorie Intake',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
            ),
            SizedBox(height: 8),
            Text(
              '500 / 2000 kcal',
              style: TextStyle(fontSize: 20, color: Color(0xFF4CAF50)),
            ),
            SizedBox(height: 16),
            Text(
              'Meal Log',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  _buildMealCard('Breakfast', 'assets/oatmeal.jpg', 150),
                  _buildMealCard('Lunch', 'assets/chicken_salad.jpg', 350),
                  _buildMealCard('Dinner', 'assets/quinoa_veggies.jpg', 400),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add meal logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CAF50),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Text('Add Meal', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            Text(
              'Hydration Tracker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
            ),
            // Add Water Intake Section Here
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(String mealType, String imagePath, int calories) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 80, // Adjust size as needed
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mealType, style: TextStyle(fontSize: 18)),
                  Text('$calories kcal', style: TextStyle(fontSize: 16, color: Color(0xFF4CAF50))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

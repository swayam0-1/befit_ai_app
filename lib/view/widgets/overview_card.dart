import 'package:flutter/material.dart';
class OverviewCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final double width;

  OverviewCard({required this.title, required this.subtitle, required this.color, required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){print('Clicked');},
      child: Container(
        // alignment: Alignment.center,
        width: width,
        margin:const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding:const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style:const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

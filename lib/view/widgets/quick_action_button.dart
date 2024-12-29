import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Widget destination;
  const QuickActionButton({super.key, required this.label, required this.icon, required this.color,required this.destination});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=>destination
            ));
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, size: 30, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style:const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

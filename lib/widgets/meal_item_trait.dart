import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      //children: [
      child: Icon(
        icon,
        size: 16,
        color: Colors.grey[300], // Matches your exact visual design
      ),
      //const SizedBox(width: 6),
      //Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      //],
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

// Provider<List<Meal>> mealsProvider = Provider((ref) {
//   // Here you can fetch or compute the list of meals based on your app's logic
//   return dummyMeals; // Replace with your actual data source
// });

// ✅ FIX: Added final keyword for standard Riverpod setup
final mealsProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});

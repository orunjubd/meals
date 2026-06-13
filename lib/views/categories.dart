import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/views/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite, // 🚀 BRIDGE CONSTRUCTOR: Receives pointer method from tab
    required this.availableMeals, // 🚀 BRIDGE CONSTRUCTOR: Receives meals data from tab
  });

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal>
  availableMeals; // 🚀 BRIDGE CONSTRUCTOR: Receives meals data from tab

  // 🚀 THE CONTROLLER ROUTING METHOD: Pushes view context forward to meals list
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    // =======================================================================
    // Alternative way USE for loop
    // =======================================================================
    // final List<Meal> filteredMeals = [];
    // for (final meal in dummyMeals) {
    //   if (meal.categories.contains(category.id)) {
    //     filteredMeals.add(meal);
    //   }
    // }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite:
              onToggleFavorite, // 🚀 Passes the favorites tunnel forward safely!
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    // appBar: AppBar(title: const Text('Categories')),
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      //======================================================================
      // children: availableCategories
      //     .map((cat) => CategoryGridItem(cat))
      //     .toList(),

      // =====================================================================
      // Alternative way USE for loop
      // =====================================================================
      children: [
        for (final cat in availableCategories)
          CategoryGridItem(
            category: cat,
            onSelectCategory: () =>
                _selectCategory(context, cat), // Passes function pointer down
          ),
      ],
    );
    //);
  }
}

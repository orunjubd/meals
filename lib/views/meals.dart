import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite, // 🚀 BRIDGE CONSTRUCTOR: Continues parameters mapping pipes
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) {
        final meal = meals[index];
        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(meal.imageUrl)),
          title: Text(meal.title),
          subtitle: Text('${meal.duration} min'),
        );
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Uh on... ... No meals found!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          final meal = meals[index];
          return MealItem(
            meal: meal,
            onToggleFavorite:
                onToggleFavorite, // 🚀 PASSES BRIDGE INTO INDIVIDUAL TILES
          );
        },
      );
    }
    // 🚀 THE SMART HEADER IF/ELSE FIREWALL

    // If title is null, it means we are in the Favorites Tab! Return raw content without a second header.
    if (title == null) return content;

    //return content;
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}

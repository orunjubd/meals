import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart'; // Standard smooth image fade plugin

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  // Helper utility method to capitalize text properties nicely (e.g. 'simple' -> 'Simple')
  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip
          .hardEdge, // Forces background images to strictly respect rounded corner boundaries
      elevation: 3,
      child: InkWell(
        onTap: () {
          // TODO: Implement interactive recipe details deep-dive page routing launcher next!
        },
        child: Stack(
          children: [
            // 1. THE RECIPIE PHOTO CANVAS: Fades in network images cleanly over a placeholder
            SizedBox(
              height: 200,
              width: double.infinity,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                // We add a cache configuration to decode images lightweight inside RAM memory
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
              ),
            ),

            // 2. THE FLOATING BOTTOM TRANSLUCENT OVERLAY DETAILS BOX
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54, // Soft see-through charcoal tint overlay
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow
                          .ellipsis, // Adds ... trailing clips if title string is too long
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 3. HORIZONTAL ICON METRICS GRID METERS ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Metric 1: Preparation Timer Clock
                        Icon(Icons.schedule, size: 16, color: Colors.grey[300]),
                        const SizedBox(width: 6),
                        Text(
                          '${meal.duration} min',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Metric 2: Cooking Complexity Level Gauge
                        Icon(
                          Icons.work_outline_rounded,
                          size: 16,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _capitalize(meal.complexity.name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Metric 3: Affordability Cost Balance
                        Icon(
                          Icons.attach_money_rounded,
                          size: 16,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _capitalize(meal.affordability.name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

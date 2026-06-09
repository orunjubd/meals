import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
//import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'package:cached_network_image/cached_network_image.dart'; // Standard smooth image fade plugin

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
                // Here imgae valition err handling 3 techniques are implemented in one go:
                // 1. The imageErrorBuilder fallback engine (PHP-style if/else safety net)
                // 2. The errorBuilder fallback engine (Flutter-style if/else safety net)
                // 3. The placeholder image (a transparent pixel) that fades in while the network image is loading
                // in fluuter more 1. Image.network(); 2. FadeInImage.assetNetwork(); 3. FadeInImage.memoryNetwork(); are the 3 main ways to load network images with error handling and placeholders

                // Best solution is CachedNetworkImage  Facebook, Amazon, or Twitter, they all use a custom version of
                // CachedNetworkImage that includes advanced caching, retry logic, and error handling features to
                //ensure a smooth user experience even with unreliable network conditions.

                // 🚀 THE PHP-STYLE SAFETY "IF/ELSE" FALLBACK ENGINE
                // What it does: If the URL is broken, it intercepts the fatal crash
                // and renders a beautiful local default card placeholder instantly!
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image_outlined,
                          size: 42,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(120),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Recipe Photo Coming Soon!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // use CachedNetworkImage for better caching and error handling
              // child: CachedNetworkImage(
              //   imageUrl: meal.imageUrl,
              //   fit: BoxFit.cover,
              //   // PHASE A: Smooth fade animation duration layer built-in by default
              //   fadeInDuration: const Duration(milliseconds: 300),

              //   // PHASE B: The high-speed progress spinner wheel placeholder
              //   placeholder: (context, url) => Container(
              //     color: Theme.of(context).colorScheme.surfaceContainerHighest,
              //     alignment: Alignment.center,
              //     child: const CircularProgressIndicator(strokeWidth: 2),
              //   ),

              //   // PHASE C: The bulletproof fail-safe error widget fallback boundary
              //   errorWidget: (context, url, error) => Container(
              //     color: Theme.of(context).colorScheme.surfaceContainerHighest,
              //     alignment: Alignment.center,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.broken_image_outlined,
              //           size: 36,
              //           color: Theme.of(
              //             context,
              //           ).colorScheme.primary.withAlpha(120),
              //         ),
              //         const SizedBox(height: 4),
              //         Text(
              //           'Recipe Photo Coming Soon!',
              //           style: TextStyle(
              //             fontSize: 12,
              //             color: Theme.of(context).colorScheme.onSurfaceVariant,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ), // not used here to avoid adding extra dependencies for this simple demo, but highly recommended for production apps with lots of images and network variability
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

                    // 3. HORIZONTAL ICON METRICS GRID METERS ROW [Meta Data]
                    // ==========================================================
                    // HORIZONTAL ICON METRICS ROW (CRASH-PROOFED VERSION)
                    // ==========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Metric 1: Preparation Timer Clock
                        const Icon(
                          Icons.schedule,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${meal.duration} min',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ), // Balanced compact gap spacing
                        // Metric 2: Cooking Complexity Level Gauge
                        const Icon(
                          Icons.work_outline_rounded,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _capitalize(meal.complexity.name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ), // Balanced compact gap spacing
                        // Metric 3: Affordability Cost Balance
                        const Icon(
                          Icons.attach_money_rounded,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 2),
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

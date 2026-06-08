import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    required this.category,
    required this.onSelectCategory,
    super.key,
  });

  final Category category;
  final VoidCallback
  onSelectCategory; // VoidCallback shorter nickname for void Function() [INDEX]

  @override
  Widget build(BuildContext context) {
    // use InkWell for better visual feedback on tap;
    // but GestureDetector can also be used if you want more
    // control over the tap behavior but not the visual feedback;
    return InkWell(
      autofocus: bool.fromEnvironment('debug'),
      onTap: () {},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            //colors: [category.color.withValues(alpha: 128), category.color],
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen, // Callback function to pass routing messages to parent controllers
  });

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // 1. TOP GRAPHIC DRAWER HEADER
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(180),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.restaurant_menu_rounded,
                  size: 40,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 16),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 2. MENU ITEM LINK 1: MEALS RECIPES
          ListTile(
            leading: Icon(
              Icons.set_meal_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Meals Ledger',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              onSelectScreen('meals'); // Passes identifier message tag
            },
          ),

          const Divider(indent: 16, endIndent: 16),

          // 3. MENU ITEM LINK 2: FILTERS ENGINE
          ListTile(
            leading: Icon(
              Icons.tune_rounded,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Dietary Filters',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              onSelectScreen('filters'); // Passes identifier message tag
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

// 🚀 THE SYSTEM SCHEMAS: Strictly enumerates your available system configuration channels
enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // Centralized memory tracking Map block to record active on/off filter switch flags
  final Map<Filter, bool> _activeFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };

  // 🚀 CLEAN OPTIMIZATION TRACK DATASET: Defines labels and descriptions dynamically in an inline configuration array
  List<Map<String, dynamic>> get _filterMetaData => [
    {
      'filter': Filter.glutenFree,
      'title': 'Gluten-free',
      'subtitle': 'Only include gluten-free recipe entries.',
    },
    {
      'filter': Filter.lactoseFree,
      'title': 'Lactose-free',
      'subtitle': 'Only include lactose-free recipe entries.',
    },
    {
      'filter': Filter.vegan,
      'title': 'Vegan',
      'subtitle': 'Only include vegan recipe entries.',
    },
    {
      'filter': Filter.vegetarian,
      'title': 'Vegetarian',
      'subtitle': 'Only include vegetarian recipe entries.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          Navigator.of(context).pop(); // Snap side drawer panel shut

          if (identifier == 'meals') {
            // 🚀 FIXED: Dropped the duplicate push!
            // Popping the context off the stack returns the user safely straight to TabsScreen!
            Navigator.of(context).pop();
          }
        },
      ),
      // 🚀 LOOP RENDERING LAYER: Replaces 60 lines of copy-pasted SwitchListTiles with a single loop map!
      body: ListView(
        children: [
          for (final item in _filterMetaData)
            SwitchListTile(
              value:
                  _activeFilters[item['filter']] ??
                  false, // Reads active configuration state flag
              onChanged: (isChecked) {
                setState(() {
                  _activeFilters[item['filter'] as Filter] =
                      isChecked; // Mutates targeted mapping tracks
                });
              },
              title: Text(
                item['title'] as String,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item['subtitle'] as String,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
            ),
        ],
      ),
    );
  }
}

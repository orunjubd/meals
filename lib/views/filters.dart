import 'package:flutter/material.dart';
//import 'package:meals/widgets/main_drawer.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool>
  currentFilters; // 🚀 BRIDGE CONSTRUCTOR: Receives current filter settings from tab

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
  void initState() {
    super.initState();
    _activeFilters.addAll(
      widget.currentFilters,
    ); // 🚀 BRIDGE INITIALIZATION: Passes current filter settings from tab
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        Navigator.of(
          context,
        ).pop(_activeFilters); // Passes data map straight backward safely
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Filters')),
        // //drawer: MainDrawer(
        //   onSelectScreen: (String identifier) {
        //     Navigator.of(context).pop(); // Snap drawer panel shut
        //     if (identifier == 'meals') {
        //       Navigator.of(
        //         context,
        //       ).pop(); // Pops out to return back to home tab dashboard screens
        //     }
        //   },
        // //),
        body: ListView(
          children: [
            for (final item in _filterMetaData)
              SwitchListTile(
                value: _activeFilters[item['filter']] ?? false,
                onChanged: (isChecked) {
                  setState(() {
                    _activeFilters[item['filter'] as Filter] = isChecked;
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
      ),
    );
  }
}

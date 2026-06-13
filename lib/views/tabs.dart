import 'package:flutter/material.dart';
import 'package:meals/views/categories.dart';
import 'package:meals/views/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/views/filters.dart';

import 'package:meals/data/dummy_data.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  // 🚀 THE SYSTEM ARRAYS STORAGE POOL: Keeps track of bookmarked meals across tabs
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _activeFilters = kInitialFilters;

  // Helper dashboard flash utility alert bar (SnackBar notification layout builder)
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior:
            SnackBarBehavior.floating, // Clean modern appearance padding look
      ),
    );
  }

  // 🚀 THE STATE CONTROLLER PIPELINE: Shared method that targets items for addition/removal
  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(
          meal,
        ); // Delete item row out of array tracking memory lists
      });
      _showInfoMessage('Recipe removed from your favorites.');
    } else {
      setState(() {
        _favoriteMeals.add(
          meal,
        ); // Insert item record permanently into memory list sets
      });
      _showInfoMessage('Recipe locked into your favorites!');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // 2. SCROLL DOWN INSIDE YOUR _TabsScreenState CLASS BUILD BLOCK TRACK (Around Line 45):
  // 🚀 THE DRAWER ROUTING ROUTER INTERCEPTOR ENGINE
  // 🚀 UPGRADED ASYNC INTERCEPTOR ENGINE
  // void _setScreen(String identifier) {
  //   Navigator.of(
  //     context,
  //   ).pop(); // 1. Always snap the side drawer menu shut first!

  //   if (identifier == 'filters') {
  //     // 2. Push the Filters screen view forward onto the navigation stack layers
  //     Navigator.of(
  //       context,
  //     ).push(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
  //   }
  //   // If identifier == 'meals', it falls back naturally, remaining right on the main tab dashboards!
  // }
  // Inside lib/views/tabs.dart (Around Line 45)
  // 🚀 UPGRADED ASYNC INTERCEPTOR ENGINE
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Always snap the side drawer menu shut first!

    if (identifier == 'filters') {
      // 'await' waits for the FiltersScreen to close and returns the map sheet data!
      final Map<Filter, bool>? result = await Navigator.of(context)
          .push<Map<Filter, bool>>(
            MaterialPageRoute(
              builder: (ctx) => FiltersScreen(currentFilters: _activeFilters),
            ),
          );
      if (!mounted) return;
      setState(() {
        _activeFilters =
            result ??
            kInitialFilters; // Update filters with returned data or keep existing if null
      }); // Rebuild the UI to reflect any changes in filters
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableMeals = dummyMeals.where((meal) {
      if (_activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true; // Meal passes all active filters
    }).toList();
    // A. Default Viewport Page Slot configuration: Categories Grid Panel
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Food Categories';

    // B. Re-paints the display container instantly if the Favorites Tab button row is tapped
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        //title: '',
        meals: _favoriteMeals, // Feeds your active live favorites dataset
        onToggleFavorite:
            _toggleMealFavoriteStatus, // Keeps bookmark switches functional inside lists!
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_outlined),
            activeIcon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_rounded),
            activeIcon: Icon(Icons.star_rounded),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals/views/categories.dart';
import 'package:meals/views/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/views/filters.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  // 🚀 THE SYSTEM ARRAYS STORAGE POOL: Keeps track of bookmarked meals across tabs
  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
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

  // 2. SCROLL DOWN INSIDE YOUR _TabsScreenState CLASS BUILD BLOCK TRACK (Around Line 45):
  // 🚀 THE DRAWER ROUTING ROUTER INTERCEPTOR ENGINE
  void _setScreen(String identifier) {
    Navigator.of(
      context,
    ).pop(); // 1. Always snap the side drawer menu shut first!

    if (identifier == 'filters') {
      // 2. Push the Filters screen view forward onto the navigation stack layers
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
    // If identifier == 'meals', it falls back naturally, remaining right on the main tab dashboards!
  }

  @override
  Widget build(BuildContext context) {
    // A. Default Viewport Page Slot configuration: Categories Grid Panel
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
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

import 'package:flutter/material.dart';
import 'package:meals/views/categories.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0; // The internal tab tracking state variable

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index; // Triggers instant screen re-painting loop
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Setup default active views page pointers
    Widget activePage = const CategoriesScreen();
    String activePageTitle = 'Categories';

    // 2. Conditional Toggler: Switch view context maps if Favorites index is clicked
    if (_selectedPageIndex == 1) {
      activePage = const Center(
        child: Text(
          'Your marked favorite recipes will appear here!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle), // Dynamically switches heading strings!
      ),
      body: activePage, // Paints active screen view into core slot framework
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage, // Catches single finger click inputs
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

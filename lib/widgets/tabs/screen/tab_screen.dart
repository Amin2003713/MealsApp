import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/widgets/categories/screen/categoriesScreen.dart';
import 'package:meals/widgets/filters/screen/filter_screen.dart';
import 'package:meals/widgets/meals/screen/meals_screen.dart';
import 'package:meals/widgets/tabs/components/main_drawer.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenSate();
}

class _TabScreenSate extends ConsumerState<TabScreen> {
  _TabScreenSate();

  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleScreen(String screen) async {
    Navigator.pop(context);
    if (screen case 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FilterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var fav = ref.watch(favoriteMealsProvider);

    Widget activePage = CategoriesScreen(favorites: fav);
    var activePageTitle = 'Categories';
    if (_selectedIndex == 1) {
      activePage = MealsScreen.fromMeals('Favorite', fav ?? [], favorites: fav);
      activePageTitle = 'Favorite';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _toggleScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
        ],
      ),
    );
  }
}

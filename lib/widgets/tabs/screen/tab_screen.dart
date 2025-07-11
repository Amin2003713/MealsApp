import 'package:flutter/material.dart';
import 'package:meals/widgets/categories/screen/categoriesScreen.dart';
import 'package:meals/widgets/filters/screen/filter_screen.dart';
import 'package:meals/widgets/meals/model/meals.dart';
import 'package:meals/widgets/meals/screen/meals_screen.dart';
import 'package:meals/widgets/tabs/components/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TabScreenSate();
}

class _TabScreenSate extends State<TabScreen> {
  _TabScreenSate();

  int _selectedIndex = 0;
  List<Meal>? _favoriteMeals = [];

  Map<Filter, bool>? _filterData = {
    Filter.vegetarian: false,
    Filter.vegan: false,
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
  };

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (_favoriteMeals!.contains(meal)) {
        _favoriteMeals!.remove(meal);
        _showInfoMessage('meal ${meal.title} has been removed!');
      } else {
        _favoriteMeals!.add(meal);
        _showInfoMessage('meal ${meal.title} has been added!');
      }
      _favoriteMeals ??= [];
    });
  }

  void _toggleScreen(String screen) async {
    Navigator.pop(context);
    if (screen case 'Filters') {
      var result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(
            onFilterChanged: filterChanged,
            filters: _filterData!,
          ),
        ),
      );

      setState(() {
        _filterData = result ?? _filterData;
      });
    }
  }

  void filterChanged(bool filter) {}

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onFavorite: _toggleFavorite,
      favorites: _favoriteMeals,
      filters: _filterData!,
    );
    var activePageTitle = 'Categories';
    if (_selectedIndex == 1) {
      activePage = MealsScreen.fromMeals(
        'Favorite',
        onFavorite: _toggleFavorite,
        _favoriteMeals ?? [],
        favorites: _favoriteMeals,
        filters: _filterData!,
      );
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

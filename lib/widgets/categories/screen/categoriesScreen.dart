import 'package:flutter/material.dart';
import 'package:meals/widgets/categories/model/category.dart';
import 'package:meals/widgets/filters/screen/filter_screen.dart';
import 'package:meals/widgets/meals/model/meals.dart';

import '../../meals/screen/meals_screen.dart';
import '../components/category_grid_items.dart';
import '../model/dummies/dummyCategoryData.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    required this.onFavorite,
    required this.favorites,
    super.key,
    required this.filters,
  });

  final void Function(Meal meal) onFavorite;
  final List<Meal>? favorites;

  final Map<Filter, bool> filters;

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen.fromCategory(
          category,
          onFavorite: onFavorite,
          favorites: favorites,
          filters: filters,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          ...availableCategories.map(
            (e) => CategoryGridItems(
              category: e,
              onSelect: _selectCategory,
              onFavorite: onFavorite,
            ),
          ),
        ],
      ),
    );
  }
}

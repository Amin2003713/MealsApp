import 'package:flutter/material.dart';
import 'package:meals/widgets/meals/components/item/meal_details.dart';
import 'package:meals/widgets/meals/components/list/meal_item.dart';
import 'package:meals/widgets/meals/model/meals.dart';

import '../../categories/model/category.dart' show Category;
import '../model/dummies/meals_dummy.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen({super.key, this.category, this.meals, required this.onFavorite});

  MealsScreen.fromCategory(
    this.category, {
    super.key,
    required this.onFavorite,
  }) {
    // You can populate this list from dummyMeals or a data source:
    meals = dummyMeals
        .where((meal) => meal.categories.contains(category!.id))
        .toList();
  }

  MealsScreen.fromMeals(
    String title,
    this.meals, {
    super.key,
    required this.onFavorite,
  }) {
    category = Category(id: 'Favorite', title: title);
  }

  final void Function(Meal meal) onFavorite;

  _onMealSelected(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetails(meal: meal, onFavorite: onFavorite),
      ),
    );
  }

  Widget _mealScreenContents(ThemeData theme) =>
      (meals != null && meals!.isNotEmpty)
      ? ListView.builder(
          itemCount: meals!.length,
          itemBuilder: (ctx, index) =>
              MealItem(meal: meals![index], onMealSelected: _onMealSelected),
        )
      : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ops ... nothing here!',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Try another category!',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.surfaceBright,
                ),
              ),
            ],
          ),
        );

  Category? category;
  List<Meal>? meals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return (category!.id == 'Favorite')
        ? _mealScreenContents(theme)
        : Scaffold(
            appBar: AppBar(title: Text(category!.title)),
            body: _mealScreenContents(theme),
          );
  }
}

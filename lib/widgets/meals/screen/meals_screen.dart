import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/meals/components/item/meal_details.dart';
import 'package:meals/widgets/meals/components/list/meal_item.dart';
import 'package:meals/widgets/meals/model/meals.dart';

import '../../categories/model/category.dart' show Category;
import '../../filters/screen/filter_screen.dart';
import '../model/dummies/meals_dummy.dart';

class MealsScreen extends ConsumerWidget {
  MealsScreen({super.key, this.category, this.meals, required this.favorites});

  MealsScreen.fromCategory(this.category, {super.key, required this.favorites});

  MealsScreen.fromMeals(
    String title,
    this.meals, {
    super.key,
    required this.favorites,
  }) {
    category = Category(id: 'Favorite', title: title);
  }

  final List<Meal>? favorites;
  Category? category;
  List<Meal>? meals;

  _onMealSelected(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MealDetails(meal: meal, favorites: favorites ?? []),
      ),
    );
  }

  Widget _mealScreenContents(ThemeData theme, WidgetRef ref) {
    var filter = ref.watch(filtersProvider);

    meals = category!.title != 'Favorite'
        ? dummyMeals
              .where((meal) => meal.categories.contains(category!.id))
              .where((meal) {
                if (filter[Filter.glutenFree]! && !meal.isGlutenFree) {
                  return false;
                }
                if (filter[Filter.lactoseFree]! && !meal.isLactoseFree) {
                  return false;
                }
                if (filter[Filter.vegan]! && !meal.isVegan) return false;
                if (filter[Filter.vegetarian]! && !meal.isVegetarian) {
                  return false;
                }
                return true;
              })
              .toList()
        : favorites;

    return (meals != null && meals!.isNotEmpty)
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return (category!.id == 'Favorite')
        ? _mealScreenContents(theme, ref)
        : Scaffold(
            appBar: AppBar(title: Text(category!.title)),
            body: _mealScreenContents(theme, ref),
          );
  }
}

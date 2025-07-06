import 'package:flutter/material.dart';
import 'package:meals/widgets/categories/model/category.dart';
import 'package:meals/widgets/meals/model/meals.dart';

class CategoryGridItems extends StatelessWidget {
  const CategoryGridItems({
    required this.category,
    required this.onSelect,
    super.key,
    required this.onFavorite,
  });
  final void Function(Meal meal) onFavorite;
  final Category category;

  final void Function(BuildContext context, Category category) onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onSelect(context, category);
        },
        splashColor: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [category.color, theme.colorScheme.scrim],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.decal,
              transform: const GradientRotation(45),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            category.title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}

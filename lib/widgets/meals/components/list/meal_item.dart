import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../model/meals.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onMealSelected});

  final Meal meal;
  final Function(BuildContext context, Meal meal) onMealSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaTextStyle = TextStyle(
      color: theme.colorScheme.onSurface.withAlpha(154),
      fontSize: 14,
    );

    return InkWell(
      onTap: () {
        onMealSelected(context, meal);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    meal.title,
                    textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.schedule),
                          const SizedBox(width: 4),
                          Text('${meal.duration} min', style: metaTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.work),
                          const SizedBox(width: 4),
                          Text(meal.complexity.name, style: metaTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.attach_money),
                          const SizedBox(width: 4),
                          Text(meal.affordability.name, style: metaTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../model/meals.dart';

class MealDetails extends ConsumerStatefulWidget {
  const MealDetails({super.key, required this.meal, required this.favorites});

  final Meal meal;
  final List<Meal> favorites;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MealDetailsState();
}

class MealDetailsState extends ConsumerState<MealDetails> {
  IconData faveIcon = Icons.star_outline;

  void _onFave() {
    setState(() {
      faveIcon = widget.favorites.contains(widget.meal)
          ? Icons.star
          : Icons.star_outline;
    });

    final added = ref
        .read(favoriteMealsProvider.notifier)
        .toggleFavorite(widget.meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(added ? 'added to favorites' : 'removed from favorites'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaTextStyle = TextStyle(
      color: theme.colorScheme.onSurface.withAlpha(154),
      fontSize: 14,
    );

    final meal = widget.meal;

    faveIcon = ref.watch(favoriteMealsProvider).contains(widget.meal)
        ? Icons.star
        : Icons.star_outline;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [IconButton(onPressed: _onFave, icon: Icon(faveIcon))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Top section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(meal.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.title,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.schedule, size: 18),
                            const SizedBox(width: 8),
                            Text('${meal.duration} min', style: metaTextStyle),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.work, size: 18),
                            const SizedBox(width: 4),
                            Text(meal.complexity.name, style: metaTextStyle),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, size: 18),
                            const SizedBox(width: 4),
                            Text(meal.affordability.name, style: metaTextStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// Ingredients
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ingredients',
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(154),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...meal.ingredients.map(
                (ingredient) => ListTile(
                  dense: true,
                  minTileHeight: 8,
                  minVerticalPadding: 8,
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(ingredient),
                ),
              ),
              const SizedBox(height: 24),

              /// Steps
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Steps',
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(154),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...meal.steps.asMap().entries.map(
                (entry) => ListTile(
                  dense: true,
                  minTileHeight: 8,
                  minVerticalPadding: 8,
                  leading: CircleAvatar(
                    radius: 14,
                    child: Text('${entry.key + 1}'),
                  ),
                  title: Text(entry.value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

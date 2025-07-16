import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/widgets/meals/model/meals.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  void _toggleFavorite(BuildContext context, WidgetRef ref) {
    final wasAdded = ref
        .read(favoriteMealsProvider.notifier)
        .toggleFavorite(meal);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            wasAdded ? 'Added to favorites' : 'Removed from favorites',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);
    final theme = Theme.of(context);
    final metaStyle = TextStyle(
      color: theme.colorScheme.onSurface.withAlpha(154),
      fontSize: 14,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _toggleFavorite(context, ref),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween(begin: 0.97, end: 1.0).animate(animation),
                child: child,
              ),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_outline,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MealHeader(meal: meal, metaStyle: metaStyle),
              const SizedBox(height: 24),
              _SectionTitle('Ingredients'),
              const SizedBox(height: 8),
              ...meal.ingredients.map(
                (ing) => ListTile(
                  dense: true,
                  minVerticalPadding: 8,
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(ing),
                ),
              ),
              const SizedBox(height: 24),
              _SectionTitle('Steps'),
              const SizedBox(height: 8),
              ...meal.steps.asMap().entries.map(
                (entry) => ListTile(
                  dense: true,
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

class _MealHeader extends StatelessWidget {
  const _MealHeader({required this.meal, required this.metaStyle});

  final Meal meal;
  final TextStyle metaStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: meal.id,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit.cover,
                ),
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
              _MetaRow(icon: Icons.schedule, text: '${meal.duration} min'),
              const SizedBox(height: 8),
              _MetaRow(icon: Icons.work, text: meal.complexity.name),
              const SizedBox(height: 8),
              _MetaRow(icon: Icons.attach_money, text: meal.affordability.name),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final metaStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface.withAlpha(154),
      fontSize: 14,
    );
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Text(text, style: metaStyle),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(154),
      ),
    );
  }
}

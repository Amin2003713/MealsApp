import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    var filterValues = ref.watch(filtersProvider);
    var setFilter = ref.read(filtersProvider.notifier).setFilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjust your meal selection'),
        elevation: 2,
      ),
      // drawer: MainDrawer(onSelectScreen: _toggleScreen),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: SwitchListTile(
                  value: filterValues[Filter.glutenFree]!,
                  onChanged: (value) {
                    setFilter(Filter.glutenFree, value);
                  },
                  title: Text(
                    'Gluten-free',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    'Only include meals that are gluten-free.',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  activeColor: theme.colorScheme.onTertiaryContainer,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                ),
              ),

              // You can easily extend more filters here:
              // e.g. lactose-free, vegetarian, vegan, etc.
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: SwitchListTile(
                  value: filterValues[Filter.lactoseFree]!,
                  onChanged: (value) {
                    setFilter(Filter.lactoseFree, value);
                  },
                  title: Text(
                    'Lactose-free',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    'Only include meals that are lactose-free.',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  activeColor: theme.colorScheme.onTertiaryContainer,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                ),
              ),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: SwitchListTile(
                  value: filterValues[Filter.vegetarian]!,
                  onChanged: (value) {
                    setFilter(Filter.vegetarian, value);
                  },
                  title: Text(
                    'Vegetarian',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    'Only include meals that are vegetarian.',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  activeColor: theme.colorScheme.onTertiaryContainer,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: SwitchListTile(
                  value: filterValues[Filter.vegan]!,
                  onChanged: (value) {
                    setFilter(Filter.vegan, value);
                  },
                  title: Text(
                    'vegan',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    'Only include meals that are vegan.',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  activeColor: theme.colorScheme.onTertiaryContainer,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

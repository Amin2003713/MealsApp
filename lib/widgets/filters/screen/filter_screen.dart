import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
    required this.onFilterChanged,
    required this.filters,
  });

  final void Function(bool isGlutenFree) onFilterChanged;
  final Map<Filter, bool> filters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    _isGlutenFree = widget.filters[Filter.glutenFree]!;
    _isLactoseFree = widget.filters[Filter.lactoseFree]!;
    _isVegan = widget.filters[Filter.vegan]!;
    _isVegetarian = widget.filters[Filter.vegetarian]!;

    super.initState();
  }

  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  void _onPop(bool didPop, Map<Filter, bool>? result) {
    if (didPop) return;
    result = {
      Filter.vegetarian: _isVegetarian,
      Filter.vegan: _isVegan,
      Filter.glutenFree: _isGlutenFree,
      Filter.lactoseFree: _isLactoseFree,
    };
    Navigator.of(context).pop(result);
  }

  // void _toggleScreen(String screen) {
  //   Navigator.pop(context);
  //   if (screen case 'Meals') {
  //     Navigator.of(
  //       context,
  //     ).pushReplacement(MaterialPageRoute(builder: (context) => TabScreen()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjust your meal selection'),
        elevation: 2,
      ),
      // drawer: MainDrawer(onSelectScreen: _toggleScreen),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: _onPop,
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
                    value: _isGlutenFree,
                    onChanged: (value) {
                      setState(() {
                        _isGlutenFree = value;
                      });
                      widget.onFilterChanged(_isGlutenFree);
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
                    value: _isLactoseFree,
                    onChanged: (value) {
                      setState(() {
                        _isLactoseFree = value;
                      });
                      widget.onFilterChanged(_isLactoseFree);
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
                    value: _isVegetarian,
                    onChanged: (value) {
                      setState(() {
                        _isVegetarian = value;
                      });
                      widget.onFilterChanged(_isVegetarian);
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
                    value: _isVegan,
                    onChanged: (value) {
                      setState(() {
                        _isVegan = value;
                      });
                      widget.onFilterChanged(_isVegan);
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
      ),
    );
  }
}

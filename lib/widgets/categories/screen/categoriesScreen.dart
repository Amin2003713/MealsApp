import 'package:flutter/material.dart';
import 'package:meals/widgets/categories/model/category.dart';
import 'package:meals/widgets/meals/model/meals.dart';

import '../../meals/screen/meals_screen.dart';
import '../components/category_grid_items.dart';
import '../model/dummies/dummyCategoryData.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({required this.favorites, super.key});

  final List<Meal>? favorites;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen.fromCategory(category, favorites: widget.favorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => SlideTransition(
          position: Tween(end: Offset(0, 0), begin: Offset(0, 0.3)).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInExpo,
            ),
          ),
          child: child,
        ),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: [
            ...availableCategories.map(
              (e) => CategoryGridItems(category: e, onSelect: _selectCategory),
            ),
          ],
        ),
      ),
    );
  }
}

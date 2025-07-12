import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/widgets/filters/screen/filter_screen.dart';

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
    : super({
        Filter.vegetarian: false,
        Filter.vegan: false,
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
      });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider = StateNotifierProvider((ref) => FilterNotifier());

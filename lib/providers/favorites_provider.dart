//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    if (state.contains(meal)) {
      state = state
          .where((m) => m.id != meal.id)
          .toList(); // Remove from favorites
      return false;
    } else {
      state = [
        ...state,
        meal,
      ]; // Add to favorites [... call spread operator to create new list]
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      (ref) => FavoriteMealsNotifier(),
    );

// extension FavoritesProviderExtension on ConsumerStatefulWidget {
//   void initializeFavorites(WidgetRef ref) {
//     // Not needed - StateNotifier manages state internally
//   }
// }

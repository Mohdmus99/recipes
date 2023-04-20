import 'package:flutter/cupertino.dart';
import '../models/filter.dart';
import '../models/recipe.dart';

class StateManager extends ChangeNotifier{
  List<Filter> selectedFilters = [];
  List<Recipe> favRecipes = [];

  void updatedSelectedFilters(List<Filter> newSelectedFilters) {
    selectedFilters = newSelectedFilters;
    notifyListeners();
  }

  void updateFavRecipes(Recipe newRecipe) {
    favRecipes.add(newRecipe);
    notifyListeners();
  }


}

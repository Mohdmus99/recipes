import 'package:flutter/material.dart';
import 'package:tasty/data/state_manager.dart';
import 'package:tasty/screens/recipe_details_screen.dart';
import '../models/recipe.dart';
import 'package:provider/provider.dart';
import '../widgets/recipe_item.dart';

class FavWidget extends StatefulWidget {
  const FavWidget({Key? key}) : super(key: key);

  @override
  State<FavWidget> createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  @override
  Widget build(BuildContext context) {
    List<Recipe> favRecipes = Provider.of<StateManager>(context).favRecipes;

    return SafeArea(
      child: Column(
        children: [
          const Text(
            "favorites",
            style: TextStyle(fontSize: 21),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favRecipes.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == favRecipes.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return RecipeItem(
                  data: favRecipes[index],
                  onFavoriteTap: () {
                    setState(() {
                      favRecipes[index].isFavorite =
                          !favRecipes[index].isFavorite;
                      Provider.of<StateManager>(context)
                          .updateFavRecipes(favRecipes[index]);
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipeDetailsScreen(
                                recipe: favRecipes[index],
                              )),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './recipe.dart';



class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.photoUrl, // Replace with your image URL
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name, style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      recipe.rating.round(),
                          (index) => const Icon(Icons.star, color: Colors.amber),
                    ),
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
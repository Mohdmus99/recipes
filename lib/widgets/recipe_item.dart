import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/color.dart';
import 'custom_image.dart';
import 'favorite_box.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem(
      {Key? key,
      required this.data,
      this.width = 300,
      this.onTap,
      this.onFavoriteTap})
      : super(key: key);
  final Recipe data;
  final double width;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: .1, color: darker),
          ),
        ),
        child: Row(
          children: [
            CustomImage(
              data.photoUrl,
              radius: 15,
              height: 100,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      FavoriteBox(
                        size: 17,
                        padding: 5,
                        isFavorited: data.isFavorite,
                        onTap: onFavoriteTap,
                      ),
                    ],
                  ),
                  Text(
                    data.id.toString(),
                    style: const TextStyle(fontSize: 14, color: labelColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: textColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              data.rating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

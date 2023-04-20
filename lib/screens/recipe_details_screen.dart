import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tasty/models/recipe.dart';
import '../theme/color.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 0,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.recipe.photoUrl),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.recipe.name,
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:  [
                                        const Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.black,
                                        ),
                                        Text(widget.recipe.rating.toStringAsFixed(1))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                             Text(
                              widget.recipe.topics,
                              style: const TextStyle(
                                color: inActiveColor,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: labelColor, width: 0.1)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          const Text("rating: "),
                                          Row(
                                            children:  [
                                              for (var i=1; i<=widget.recipe.rating.toInt(); i++)
                                              const Icon(
                                                Icons.star,
                                                color: primary,
                                                size: 15,
                                              ),
                                              for (var i=1; i<=5-widget.recipe.rating.toInt(); i++)
                                                const Icon(
                                                  Icons.star,
                                                  color: inActiveColor,
                                                  size: 15,
                                                ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text("Description",
                                    style: TextStyle(fontSize: 16))),
                            Text( widget.recipe.description,
                              style: const TextStyle(color: inActiveColor),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                "Ingredients",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: DottedBorder(
                                  borderType: BorderType.Rect,
                                  strokeWidth: 0.8,
                                  dashPattern: const [
                                    1,
                                  ],
                                  color: inActiveColor,
                                  child: SizedBox(
                                    height: 240,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Icon(
                                              //   Icons.trip_origin,
                                              //   color: primary,
                                              //   size: 20,
                                              // ),
                                              Text(widget.recipe.ingredients)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),

                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 45,
                left: 10,
                child: Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.6)
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ))
          ],
        ));
  }
}

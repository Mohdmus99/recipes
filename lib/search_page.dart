import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasty/recipe_card.dart';
import 'recipe.dart';
import 'recipe_service.dart';
import './dropdown.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _recipeService = RecipeService();
  final _searchTextController = TextEditingController();
  final _searchResultsSubject = BehaviorSubject<List<Recipe>>.seeded([]);
  List<Recipe> list = [];

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchResultsSubject.close();
    super.dispose();
  }

  List<FilterIns> selectedUserListDifficulty = [];
  List<FilterIns> FilterInsListDifficulty = [
    FilterIns(name: 'Easy', id: "easy"),
    FilterIns(name: 'Less than 15 Minutes', id: "under_15_minutes"),
    FilterIns(name: 'Less than 30 Minutes', id: "under_30_minutes"),
    FilterIns(name: 'Less than 45 Minutes', id: "under_45_minutes"),
    FilterIns(name: 'Less than 1 Hour', id: "under_1_hour"),
    FilterIns(name: '5 ingredients or less', id: "5_ingredients_or_less"),
  ];

  List<FilterIns> selectedUserListMeal = [];
  List<FilterIns> FilterInsListMeal= [
    FilterIns(name: 'Lunch', id: "lunch"),
    FilterIns(name: 'Dinner', id: "dinner"),
    FilterIns(name: 'Snacks', id: "snacks"),
    FilterIns(name: 'Breakfast', id: "breakfast"),
    FilterIns(name: 'Drinks', id: "drinks"),
    FilterIns(name: 'Desserts', id: "desserts"),
    FilterIns(name: 'Appetizers', id: "appetizers"),
    FilterIns(name: 'Sides', id: "sides"),
  ];

  List<FilterIns> selectedUserListSeason = [];
  List<FilterIns> FilterInsListSeason= [
    FilterIns(name: 'Spring', id: "spring"),
    FilterIns(name: 'Winter', id: "winter"),
    FilterIns(name: 'Fall', id: "fall"),
    FilterIns(name: 'Summer', id: "summer"),
  ];

  List<FilterIns> selectedUserListDietry = [];
  List<FilterIns> FilterInsListDietry = [
    FilterIns(name: 'Healthy', id: "healthy"),
    FilterIns(name: 'Dairy free', id: "dairy_free"),
    FilterIns(name: 'Vegetarian', id: "vegetarian"),
    FilterIns(name: 'Pescatarian', id: "pescatarian"),
    FilterIns(name: 'Keto', id: "keto"),
    FilterIns(name: 'Contains Alcohol', id: "contains_alcohol"),
    FilterIns(name: 'Vegan', id: "vegan"),
  ];

  List<FilterIns> selectedUserListHealthy = [];
  List<FilterIns> FilterInsListHealthy = [
    FilterIns(name: 'High Fiber', id: "high_fiber"),
    FilterIns(name: 'high Protein', id: "high_protein"),
    FilterIns(name: 'Low Calorie', id: "low_calorie"),
    FilterIns(name: 'Low Sugar', id: "low_sugar"),
    FilterIns(name: 'Low Carb', id: "low_carb"),
    FilterIns(name: 'Contains Alcohol', id: "contains_alcohol"),
    FilterIns(name: 'Vegan', id: "vegan"),
  ];


  void openFilterDialog() async {
    await FilterListDialog.display<FilterIns>(
      context,
      listData: FilterInsListDifficulty,
      selectedListData: selectedUserListDifficulty,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserListDifficulty = List.from(list!);
        });
        Navigator.pop(context);
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }
  void openFilterDialogMeal() async {
    await FilterListDialog.display<FilterIns>(
      context,
      listData: FilterInsListMeal,
      selectedListData: selectedUserListDifficulty,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserListDifficulty = List.from(list!);
        });
        Navigator.pop(context);
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }
  void openFilterDialogSeason() async {
    await FilterListDialog.display<FilterIns>(
      context,
      listData: FilterInsListSeason,
      selectedListData: selectedUserListDifficulty,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserListDifficulty = List.from(list!);
        });
        Navigator.pop(context);
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }
  void openFilterDialogDietry() async {
    await FilterListDialog.display<FilterIns>(
      context,
      listData: FilterInsListDietry,
      selectedListData: selectedUserListDifficulty,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserListDifficulty = List.from(list!);
        });
        Navigator.pop(context);
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }
  void openFilterDialogHealthy() async {
    await FilterListDialog.display<FilterIns>(
      context,
      listData: FilterInsListHealthy,
      selectedListData: selectedUserListDifficulty,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserListDifficulty = List.from(list!);
        });
        Navigator.pop(context);
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var safeHeight = MediaQuery.of(context).size.height;
    var safeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Search'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchTextController,
            onChanged: (query) {
              // _searchResultsSubject.add([]);



              if (query.isNotEmpty) {
                print("query");
                print(query);

              }
            },
            decoration: InputDecoration(
              hintText: 'Search for recipes...',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
          IconButton(onPressed: ()async {
            list = await _recipeService.searchRecipes(selectedUserListDifficulty, _searchTextController.text);
            print("list.length");
            print(list.length);
            setState(() {
              print("search");

              _recipeService
                  .searchRecipes(selectedUserListDifficulty, _searchTextController.text)
                  .then(_searchResultsSubject.add);
            });
          }, icon: Icon(Icons.search)),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: safeHeight / 5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: Colors.black54),
                    child: InkWell(
                      onTap: () {
                        openFilterDialog();
                      },
                      child: const Text("Difficulty", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: Colors.black54),
                    child: InkWell(
                      onTap: () {
                        openFilterDialogMeal();
                      },
                      child: const Text("Meal Type", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: Colors.black54),
                    child: InkWell(
                      onTap: () {
                        openFilterDialogSeason();
                      },
                      child: const Text("Season", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: Colors.black54),
                    child: InkWell(
                      onTap: () {
                        openFilterDialogDietry();
                      },
                      child: const Text("Dietary level", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: Colors.black54),
                    child: InkWell(
                      onTap: () {
                        openFilterDialogHealthy();
                      },
                      child: const Text("Healthy factors", style: TextStyle(color: Colors.white),),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: StreamBuilder<List<Recipe>>(
              stream: _searchResultsSubject.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("snapshot.data?.length");
                  print(snapshot.data?.length);
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final recipe = snapshot.data![index];
                      return RecipeCard(recipe: recipe);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterIns {
  final String id;
  final String name;

  FilterIns({required this.name, required this.id});
}




// DropDownMenu(
// locationsList: const <String>[
// 'Difficulty',
// 'easy',
// 'under_15_minutes',
// 'under_30_minutes',
// 'under_45_minutes',
// 'under_1_hour',
// ],
// requiredDrop: false,
// stringCallback: (String val) {},
// ),

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:filter_list/filter_list.dart';
import 'package:provider/provider.dart';
import 'package:tasty/screens/recipe_details_screen.dart';
import '../constans/constants.dart';
import '../models/recipe.dart';
import '../models/filter.dart';
import '../data/filters.dart';
import '../data/state_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/color.dart';
import '../data.dart';
import '../widgets/category_item.dart';
import '../widgets/custom_round_textbox.dart';
import '../widgets/icon_box.dart';
import '../widgets/recipe_item.dart';

List<Filter> selectedUserListDifficulty = [];

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _scrollController = ScrollController();
  Timer? _timer;
  List<Recipe> _recipes = [];
  int _pageNumber = 1;
  bool _isLoading = false;

  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String searchText) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: 500), () {
      if (searchText.isNotEmpty) {
        _pageNumber = 1;
        _fetchData(_searchTextController.text,"new");

        // callFetch();
      } else {
        setState(() {
          _recipes = [];
        });
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData(_searchTextController.text,"scrolling");
      // callFetch();
    }
  }

  Future<void> _fetchData([String? searchText, String? action]) async {
    if (_isLoading) {
      return;
    }

    print(searchText);
    setState(() {
      _isLoading = true;
    });

    String apiUrl =
        'https://tasty.p.rapidapi.com/recipes/list?page=$_pageNumber&size=20';
    if (searchText != null) {
      apiUrl += '&q=$searchText';
    }

    if (selectedUserListDifficulty.isNotEmpty) {
      String allTags = "";
      int i = 0;
      selectedUserListDifficulty.forEach((element) {
        if (i == 0) {
          allTags = allTags + element.id;
        } else {
          allTags = allTags + "," + element.id;
        }
        i = i + 1;
      });
      apiUrl += '&tags=$allTags';
    }

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': 'tasty.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      // final results = jsonDecode(response.body)['results'];
      final jsonBody = json.decode(response.body);
      final jsonRecipes = jsonBody['results'] as List<dynamic>;
      setState(() {
        if (action == "new"){
          _recipes = jsonRecipes
              .map((jsonRecipe) => Recipe.fromJson(jsonRecipe))
              .toList();
        } else if (action == "scrolling"){
          _recipes.addAll(jsonRecipes
              .map((jsonRecipe) => Recipe.fromJson(jsonRecipe))
              .toList());

        }
        _pageNumber++;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
    print(apiUrl);
    print(apiUrl);
    print(apiUrl);
  }

  // _onSearchTextChanged
  Widget _buildRecipeList(BuildContext context) {
    List<Recipe> favRecipes = Provider.of<StateManager>(context).favRecipes;

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 3),
                margin:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                height: 40,
                decoration: BoxDecoration(
                  color: textBoxColor,
                  border: Border.all(color: textBoxColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    )
                  ],
                ),
                child: TextField(
                  controller: _searchTextController,
                  onChanged: _onSearchTextChanged,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                ),
              )),
            ],
          ),
          filtersFragment(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _recipes.length + (_isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == _recipes.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return RecipeItem(
                  data: _recipes[index],
                  onFavoriteTap: () {
                    setState(() {
                      _recipes[index].isFavorite = !_recipes[index].isFavorite;
                      Provider.of<StateManager>(context, listen: false)
                          .updateFavRecipes(_recipes[index]);
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipeDetailsScreen(
                                recipe: _recipes[index],
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

  Widget filtersFragment() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      height: 60,
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
              onTap: () async {
                await FilterListDialog.display<Filter>(
                  context,
                  listData: Filters.dietaryFilters,
                  selectedListData: selectedUserListDifficulty,
                  choiceChipLabel: (user) => user!.name,
                  validateSelectedItem: (list, val) => list!.contains(val),
                  onItemSearch: (user, query) {
                    return user.name!
                        .toLowerCase()
                        .contains(query.toLowerCase());
                  },
                  onApplyButtonClick: (list) {
                    setState(() {
                      selectedUserListDifficulty = List.from(list!);
                    });
                    Navigator.pop(context);
                    _fetchData(_searchTextController.text,"new");
                    // _recipeService
                    //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
                    //     .then(_searchResultsSubject.add);
                  },
                );
              },
              child: const Text(
                "Difficulty",
                style: TextStyle(color: Colors.white),
              ),
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
              child: const Text(
                "Meal Type",
                style: TextStyle(color: Colors.white),
              ),
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
              child: const Text(
                "Season",
                style: TextStyle(color: Colors.white),
              ),
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
              child: const Text(
                "Dietary level",
                style: TextStyle(color: Colors.white),
              ),
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
              child: const Text(
                "Healthy factors",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openFilterDialog() async {
    await FilterListDialog.display<Filter>(
      context,
      listData: Filters.dietaryFilters,
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
        _fetchData(_searchTextController.text,"new");
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }

  void openFilterDialogMeal() async {
    await FilterListDialog.display<Filter>(
      context,
      listData: Filters.mealFilters,
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
        _fetchData(_searchTextController.text,"new");
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }

  void openFilterDialogSeason() async {
    await FilterListDialog.display<Filter>(
      context,
      listData: Filters.seasonFilters,
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
        _fetchData(_searchTextController.text,"new");
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }

  void openFilterDialogDietry() async {
    await FilterListDialog.display<Filter>(
      context,
      listData: Filters.dietaryFilters,
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
        _fetchData(_searchTextController.text,"new");
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }

  void openFilterDialogHealthy() async {
    await FilterListDialog.display<Filter>(
      context,
      listData: Filters.nutritionalValueFilters,
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
        _fetchData(_searchTextController.text,"new");
        // _recipeService
        //     .searchRecipes(selectedUserListDifficulty,_searchTextController.text)
        //     .then(_searchResultsSubject.add);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Filter> selectedFilters =
        Provider.of<StateManager>(context, listen: false).selectedFilters;
    List<Recipe> favRecipes = Provider.of<StateManager>(context).favRecipes;

    return Scaffold(
      body: _buildRecipeList(context),
    );
  }



  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Explore",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildSearchBlcok() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: Row(
        children: [
          const Expanded(
            child: CustomRoundTextBox(
              hint: "Search",
              prefix: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconBox(
            radius: 50,
            padding: 8,
            child: SvgPicture.asset(
              "assets/icons/filter1.svg",
              color: darker,
              width: 18,
              height: 18,
            ),
          )
        ],
      ),
    );
  }

  int selectedCategoryIndex = 0;

  Widget buildCategory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 7, 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              data: categories[index],
              isSelected: index == selectedCategoryIndex,
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

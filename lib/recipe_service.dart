import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasty/search_page.dart';
import './recipe.dart';

class RecipeService {
  static const _apiKey = '6cbadfa0a6msh2a2b3c1493d3eb9p159dfbjsn74699e7acc60';
  static const _baseUrl = 'https://tasty.p.rapidapi.com/recipes/list';

  Future<List<Recipe>> searchRecipes(List<FilterIns> list, String text) async {


    String endPointUrl="https://tasty.p.rapidapi.com/recipes/list";
    String allTags = "";


    if (text != "" && list.isNotEmpty){
      // we have the two options

      int i = 0;
      list.forEach((element) {
        if(i == 0){
          allTags = allTags + element.id;
        }else{
          allTags = allTags + "," + element.id;
        }
        i = i + 1;

      });
      endPointUrl = 'https://tasty.p.rapidapi.com/recipes/list?q=$text&tags=${allTags}';


    } else if (text != ""){
      // we only have text
      endPointUrl = 'https://tasty.p.rapidapi.com/recipes/list?q=$text&from=0&size=20';



    } else if(list.isNotEmpty){

      int i = 0;
      list.forEach((element) {
        if(i == 0){
          allTags = allTags + element.id;
        }else{
          allTags = allTags + "," + element.id;
        }
        i = i + 1;

      });
      // endPointUrl = 'https://tasty.p.rapidapi.com/recipes/list?tags=${allTags}';
      endPointUrl = 'https://tasty.p.rapidapi.com/recipes/list?&size=80&tags=${allTags}';

    }

    // endPointUrl = "https://tasty.p.rapidapi.com/recipes/list?q=chicken&tags=dinner";



    // '$_endPointUrl?from=0&size=20&tags=${allTags}'





    print("endPointUrl");
    print(endPointUrl);
    print(allTags);
    final response = await http.get(


      // Uri.parse('$_baseUrl?from=0&size=20'),
      Uri.parse(endPointUrl),
      // Uri.parse('$endPointUrl?from=0&size=20&tags=${allTags}'),
      // Uri.parse('$_baseUrl?q=$query&from=0&size=20'),

      headers: {
        'x-rapidapi-host': 'tasty.p.rapidapi.com',
        'x-rapidapi-key': _apiKey,
      },

    );


    if (response.statusCode == 200) {
      print(response.body);
      final jsonBody = json.decode(response.body);
      final jsonRecipes = jsonBody['results'] as List<dynamic>;
      print("jsonRecipes.first");
      print(jsonRecipes.length);
      Recipe r = Recipe.fromJson(jsonRecipes.first);
      print(r.name);
      print(r.name);
      print(r.name);
      print(r.name);
      print(jsonRecipes.first['name']);
      // final ff = jsonRecipes.map((jsonRecipe) => Recipe.fromJson(jsonRecipe)).toList();
      print("jsonRecipes.first");
      // print(ff.first);
      return jsonRecipes.map((jsonRecipe) => Recipe.fromJson(jsonRecipe)).toList();

    } else {
      throw Exception('Failed to search for recipes: ${response.statusCode}');
    }
  }
}

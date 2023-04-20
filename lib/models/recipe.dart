class Recipe {
  final int id;
  final String name;
  final String photoUrl;
  final String description;
  final String topics;
  final String ingredients;

  // final List<String> topics;
  final double rating;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.topics,
    required this.ingredients,
    required this.rating,
    required this.isFavorite,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    String allTopics = "";
    String allIngredients = "";
    List<String> allIngredientsList = [];

    if (json['topics'] != null) {
      print(json['topics']);

      json['topics'].map((dynamic item) {
        print(item['name']);

        allTopics = "$allTopics${item['name']!}\n";

        Map<String, String> map = {};
        item.forEach((key, value) {
          map[key.toString()] = value.toString();
        });
        return map;
      }).toList();

      // print(mapList);
    }

    if (json['sections'] != null) {
      json['sections'][0]['components'].map((dynamic item) {
        print(item['ingredient']['name']);

        allIngredients = "$allIngredients${item['ingredient']['name']!}\n";
        allIngredientsList.add(item['ingredient']['name']!);

        Map<String, String> map = {};
        item.forEach((key, value) {
          map[key.toString()] = value.toString();
        });
        return map;
      }).toList();

      // print(mapList);
    }

    return Recipe(
      id: json['id'],
      name: json['name'],
      photoUrl: json['thumbnail_url'],
      rating: json.containsKey('user_ratings')
          ? (json['user_ratings']['score'] != null
              ? (json['user_ratings']['count_positive'] /
                      (json['user_ratings']['count_positive'] +
                          json['user_ratings']['count_negative'])) *
                  5
              : 0.0)
          : 0.0,
      isFavorite: false,
      description: json['description']?? "",
      topics: allTopics,
      ingredients: allIngredients,
      // topics: json['topics']
    );
  }
}

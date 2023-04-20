// recipe.dart
class Recipe {
  final String name;
  final String photoUrl;
  final double rating;

  Recipe({required this.name, required this.photoUrl, required this.rating});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      photoUrl: json['thumbnail_url'],
      rating: json.containsKey('user_ratings')? (json['user_ratings']['score'] != null?
      (json['user_ratings']['count_positive']/(json['user_ratings']['count_positive']+json['user_ratings']['count_negative'])) : 0.0):0.0,


      // double.parse(((json['user_ratings']['count_positive'])).toString()) : 0.0):0.0,
      // rating: json['num_ratings'] == 0 ? 0 : json['total_score'] / json['num_ratings'],
    );
  }
}
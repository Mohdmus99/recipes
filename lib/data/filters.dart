import '../models/filter.dart';


class Filters {
  static final List<Filter> difficultyFilters = [
    Filter(name: 'Easy', id: "easy"),
    Filter(name: 'Less than 15 Minutes', id: "under_15_minutes"),
    Filter(name: 'Less than 30 Minutes', id: "under_30_minutes"),
    Filter(name: 'Less than 45 Minutes', id: "under_45_minutes"),
    Filter(name: 'Less than 1 Hour', id: "under_1_hour"),
    Filter(name: '5 ingredients or less', id: "5_ingredients_or_less"),
  ];

  static final List<Filter> mealFilters= [
    Filter(name: 'Lunch', id: "lunch"),
    Filter(name: 'Dinner', id: "dinner"),
    Filter(name: 'Snacks', id: "snacks"),
    Filter(name: 'Breakfast', id: "breakfast"),
    Filter(name: 'Drinks', id: "drinks"),
    Filter(name: 'Desserts', id: "desserts"),
    Filter(name: 'Appetizers', id: "appetizers"),
    Filter(name: 'Sides', id: "sides"),
  ];
  static final List<Filter> seasonFilters= [
    Filter(name: 'Spring', id: "spring"),
    Filter(name: 'Winter', id: "winter"),
    Filter(name: 'Fall', id: "fall"),
    Filter(name: 'Summer', id: "summer"),
  ];

  static final List<Filter> dietaryFilters = [
    Filter(name: 'Healthy', id: "healthy"),
    Filter(name: 'Dairy free', id: "dairy_free"),
    Filter(name: 'Vegetarian', id: "vegetarian"),
    Filter(name: 'Pescatarian', id: "pescatarian"),
    Filter(name: 'Keto', id: "keto"),
    Filter(name: 'Contains Alcohol', id: "contains_alcohol"),
    Filter(name: 'Vegan', id: "vegan"),
  ];

  static final List<Filter> nutritionalValueFilters = [
    Filter(name: 'High Fiber', id: "high_fiber"),
    Filter(name: 'high Protein', id: "high_protein"),
    Filter(name: 'Low Calorie', id: "low_calorie"),
    Filter(name: 'Low Sugar', id: "low_sugar"),
    Filter(name: 'Low Carb', id: "low_carb"),
    Filter(name: 'Contains Alcohol', id: "contains_alcohol"),
    Filter(name: 'Vegan', id: "vegan"),
  ];
}
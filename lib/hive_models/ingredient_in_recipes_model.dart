import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

part 'ingredient_in_recipes_model.g.dart';

@HiveType(typeId: 6)
class IngredientInRecipesModel {
  @HiveField(0)
  IngredientModel ingredient;

  @HiveField(1)
  double amount;

  IngredientInRecipesModel({required this.ingredient, required this.amount});

  factory IngredientInRecipesModel.fromJson(Map<String, dynamic> json) {
    return IngredientInRecipesModel(
      ingredient: IngredientModel.fromJson(json['ingredient']),
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredient': ingredient.toJson(),
      'amount': amount,
    };
  }
}

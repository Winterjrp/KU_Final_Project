import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_in_recipes_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

part 'recipes_model.g.dart';

RecipesModel recipesModelFromJson(String str) =>
    RecipesModel.fromJson(json.decode(str));

String recipesModelToJson(RecipesModel data) => json.encode(data.toJson());

@HiveType(typeId: 7)
class RecipesModel {
  @HiveField(0)
  String recipesID;

  @HiveField(1)
  String recipesName;

  @HiveField(2)
  String petTypeName;

  @HiveField(3)
  List<IngredientInRecipesModel> ingredientInRecipes;

  @HiveField(4)
  List<NutrientModel> nutrient;

  RecipesModel(
      {required this.recipesID,
      required this.recipesName,
      required this.petTypeName,
      required this.ingredientInRecipes,
      required this.nutrient});

  factory RecipesModel.fromJson(Map<String, dynamic> json) => RecipesModel(
        recipesID: json["recipesID"],
        recipesName: json["recipesName"],
        petTypeName: json["petTypeName"],
        ingredientInRecipes: List<IngredientInRecipesModel>.from(
            json["ingredientInRecipes"]
                .map((x) => IngredientInRecipesModel.fromJson(x))),
        nutrient: List<NutrientModel>.from(
            json["nutrient"].map((x) => NutrientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipesID": recipesID,
        "recipesName": recipesName,
        "petTypeName": petTypeName,
        "ingredientInRecipes":
            List<dynamic>.from(ingredientInRecipes.map((x) => x.toJson())),
        "nutrient": List<dynamic>.from(nutrient.map((x) => x.toJson())),
      };
}

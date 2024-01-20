import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_in_recipes_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

part 'recipes_model.g.dart';

RecipeModel recipesModelFromJson(String str) =>
    RecipeModel.fromJson(json.decode(str));

String recipesModelToJson(RecipeModel data) => json.encode(data.toJson());

@HiveType(typeId: 7)
class RecipeModel {
  @HiveField(0)
  String recipeId;

  @HiveField(1)
  String recipesName;

  @HiveField(2)
  String petTypeName;

  @HiveField(3)
  List<IngredientInRecipeModel> ingredientInRecipeList;

  @HiveField(4)
  List<NutrientModel> nutrient;

  RecipeModel(
      {required this.recipeId,
      required this.recipesName,
      required this.petTypeName,
      required this.ingredientInRecipeList,
      required this.nutrient});

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        recipeId: json["recipesID"],
        recipesName: json["recipesName"],
        petTypeName: json["petTypeName"],
        ingredientInRecipeList: List<IngredientInRecipeModel>.from(
            json["ingredientInRecipes"]
                .map((x) => IngredientInRecipeModel.fromJson(x))),
        nutrient: List<NutrientModel>.from(
            json["nutrient"].map((x) => NutrientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipesID": recipeId,
        "recipesName": recipesName,
        "petTypeName": petTypeName,
        "ingredientInRecipes":
            List<dynamic>.from(ingredientInRecipeList.map((x) => x.toJson())),
        "nutrient": List<dynamic>.from(nutrient.map((x) => x.toJson())),
      };
}

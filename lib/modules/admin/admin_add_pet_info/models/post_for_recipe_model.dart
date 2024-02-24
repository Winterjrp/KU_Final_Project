import 'dart:convert';

PostDataForRecipeModel postDataForRecipeModelFromJson(String str) =>
    PostDataForRecipeModel.fromJson(json.decode(str));

String postDataForRecipeModelToJson(PostDataForRecipeModel data) =>
    json.encode(data.toJson());

class PostDataForRecipeModel {
  double petFactorNumber;
  String petTypeName;
  List<String> petChronicDiseaseList;
  int selectedType;
  double petWeight;
  List<SelectedIngredientList> selectedIngredientList;

  PostDataForRecipeModel({
    required this.petFactorNumber,
    required this.petTypeName,
    required this.petChronicDiseaseList,
    required this.selectedType,
    required this.petWeight,
    required this.selectedIngredientList,
  });

  factory PostDataForRecipeModel.fromJson(Map<String, dynamic> json) =>
      PostDataForRecipeModel(
        petFactorNumber: json["petFactorNumber"]?.toDouble(),
        petTypeName: json["petTypeName"],
        petChronicDiseaseList:
            List<String>.from(json["petChronicDiseaseList"].map((x) => x)),
        selectedType: json["selectedType"]?.toInt(),
        petWeight: json["petWeight"]?.toDouble(),
        selectedIngredientList: List<SelectedIngredientList>.from(
            json["selectedIngredientList"]
                .map((x) => SelectedIngredientList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "petFactorNumber": petFactorNumber,
        "petTypeName": petTypeName,
        "petChronicDiseaseList":
            List<dynamic>.from(petChronicDiseaseList.map((x) => x)),
        "selectedType": selectedType,
        "petWeight": petWeight,
        "selectedIngredientList":
            List<dynamic>.from(selectedIngredientList.map((x) => x.toJson())),
      };
}

class SelectedIngredientList {
  String ingredientId;
  String ingredientName;

  SelectedIngredientList({
    required this.ingredientId,
    required this.ingredientName,
  });

  factory SelectedIngredientList.fromJson(Map<String, dynamic> json) =>
      SelectedIngredientList(
        ingredientId: json["ingredientId"],
        ingredientName: json["ingredientName"],
      );

  Map<String, dynamic> toJson() => {
        "ingredientId": ingredientId,
        "ingredientName": ingredientName,
      };
}

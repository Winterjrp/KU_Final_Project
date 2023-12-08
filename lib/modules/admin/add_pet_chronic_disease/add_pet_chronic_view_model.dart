import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';

class AddPetChronicDiseaseViewModel {
  late List<NutrientLimitInfoModel> nutrientLimitList;
  AddPetChronicDiseaseViewModel() {
    nutrientLimitList = [
      NutrientLimitInfoModel(nutrientName: "Protein", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(
          nutrientName: "Total lipid (fat)", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(
          nutrientName: "Carbohydrate, by difference", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Ash", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Energy", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Water", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(
          nutrientName: "Fiber, total dietary", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Calcium, Ca", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Iron, Fe", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Magnesium, Mg", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Phosphorus, P", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Potassium, K", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Sodium, Na", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Zinc, Zn", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Copper, Cu", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Manganese, Mn", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Selenium, Se", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Vitamin A, IU", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(
          nutrientName: "Vitamin E (alpha-tocopherol)", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Vitamin D", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(
          nutrientName: "Vitamin C, total ascorbic acid", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Thiamin", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Riboflavin", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Niacin", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(
          nutrientName: "Pantothenic acid", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Vitamin B-6", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Vitamin B-12", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(
          nutrientName: "Choline, total", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Folic acid", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Tryptophan", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Threonine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Isoleucine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Leucine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Lysine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Methionine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Cystine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Phenylalanine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Tyrosine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Valine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Arginine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Histidine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Alanine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Aspartic acid", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Glutamic acid", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Glycine", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Proline", min: 0.0, max: 0.0),
      NutrientLimitInfoModel(nutrientName: "Serine", min: 0.0, max: 0.0),
    ];
  }

  void onMinAmountChange({required int index, required double amount}) async {
    nutrientLimitList[index].min = amount;
  }

  void onMaxAmountChange({required int index, required double amount}) async {
    nutrientLimitList[index].max = amount;
  }
}

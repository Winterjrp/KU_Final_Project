import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/update_ingredients_services/update_ingredient_service_interface.dart';

class UpdateIngredientMockService implements UpdateIngredientServiceInterface {
  @override
  Future<void> addIngredientData(
      {required IngredientModel ingredientData}) async {
    await Future.delayed(const Duration(milliseconds: 1200), () {});
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.put(ingredientData.ingredientID, ingredientData);
  }

  @override
  Future<void> editIngredientData(
      {required IngredientModel ingredientData}) async {
    await Future.delayed(const Duration(milliseconds: 1200), () {});
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.put(ingredientData.ingredientID, ingredientData);
  }
}

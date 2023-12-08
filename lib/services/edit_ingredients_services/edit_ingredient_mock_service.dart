import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/edit_ingredients_services/edit_ingredient_service_interface.dart';

class EditIngredientMockService implements EditIngredientServiceInterface {
  @override
  Future<void> updateIngredientData(
      {required IngredientModel ingredientData}) async {
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.put(ingredientData.ingredientID, ingredientData);
  }
}

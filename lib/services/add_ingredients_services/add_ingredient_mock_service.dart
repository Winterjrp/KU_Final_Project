import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/add_ingredients_services/add_ingredient_service_interface.dart';

class AddIngredientMockService implements AddIngredientServiceInterface {
  @override
  Future<void> postIngredientData(
      {required IngredientModel ingredientData}) async {
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.put(ingredientData.ingredientID, ingredientData);
  }
}

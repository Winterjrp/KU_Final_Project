import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/ingredient_info_services/ingredient_info_service_interface.dart';

class IngredientInfoMockService implements IngredientInfoServiceInterface {
  @override
  Future<void> deleteIngredientInfo({required String ingredientID}) async {
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.delete(ingredientID);
  }
}

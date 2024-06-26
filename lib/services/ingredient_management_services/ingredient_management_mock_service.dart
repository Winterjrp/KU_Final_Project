import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/services/ingredient_management_services/ingredient_management_service_interface.dart';

class IngredientManagementMockService
    implements IngredientManagementServiceInterface {
  @override
  Future<List<IngredientModel>> getIngredientListData() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    final ingredientListBox =
        await Hive.openBox<IngredientModel>('ingredientListBox');
    List<IngredientModel> ingredientListData =
        ingredientListBox.values.toList();
    return ingredientListData;
  }

  @override
  Future<void> addIngredientData(
      {required IngredientModel ingredientData}) async {
    await Future.delayed(const Duration(milliseconds: 1200), () {});
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.put(ingredientData.ingredientId, ingredientData);
  }

  @override
  Future<void> editIngredientData(
      {required IngredientModel ingredientData}) async {
    await Future.delayed(const Duration(milliseconds: 1200), () {});
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.put(ingredientData.ingredientId, ingredientData);
  }

  @override
  Future<void> deleteIngredientInfo({required String ingredientId}) async {
    await Future.delayed(const Duration(milliseconds: 1200), () {});
    Box ingredientListBox = Hive.box<IngredientModel>('ingredientListBox');
    await ingredientListBox.delete(ingredientId);
  }
}

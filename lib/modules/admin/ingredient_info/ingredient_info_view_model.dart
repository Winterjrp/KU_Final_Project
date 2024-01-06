import 'package:untitled1/services/ingredient_info_services/ingredient_info_mock_service.dart';
import 'package:untitled1/services/ingredient_info_services/ingredient_info_service_interface.dart';

class IngredientInfoViewModel {
  late IngredientInfoServiceInterface services;

  IngredientInfoViewModel() {
    services = IngredientInfoMockService();
  }

  Future<void> onUserDeleteIngredientInfo(
      {required String ingredientID}) async {
    try {
      await services.deleteIngredientInfo(ingredientId: ingredientID);
    } catch (_) {
      rethrow;
    }
  }
}

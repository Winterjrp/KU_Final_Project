import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:untitled1/data/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/manager/api_link_manager.dart';
import 'package:untitled1/modules/admin/admin_add_pet_info/models/post_for_recipe_model.dart';
import 'package:untitled1/modules/admin/admin_get_recipe/get_recipe_model.dart';
import 'package:untitled1/services/get_recipe_from_algorithm_services/get_recipe_from_algorithm_service_interface.dart';

class GetRecipeFromAlgorithmService
    implements GetRecipeFromAlgorithmServiceInterface {
  @override
  Future<GetRecipeModel> searchRecipe(
      {required PostDataForRecipeModel postDataForRecipe}) async {
    String token = await SecureStorage().readSecureData(key: "token");
    try {
      final response = await http
          .post(Uri.parse(ApiLinkManager.searchRecipeFromAlgorithm()),
              headers: <String, String>{
                // 'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              body: json.encode(postDataForRecipe.toJson()))
          .timeout(const Duration(seconds: 30));
      // print(response.body);
      if (response.statusCode == 200) {
        return GetRecipeModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error. Please try again later.');
      } else {
        throw Exception('Failed to get Recipe.');
      }
    } on TimeoutException catch (_) {
      throw Exception('Connection timeout.');
    }
  }
}

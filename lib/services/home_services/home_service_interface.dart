import 'package:untitled1/modules/normal/my_pet/models/home_model.dart';

abstract class HomeServiceInterface {
  Future<MyPetModel> getPetListData({required String userID});
}

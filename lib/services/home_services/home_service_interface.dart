import 'package:untitled1/modules/normal/home/models/home_model.dart';

abstract class HomeServiceInterface {
  Future<HomeModel> getPetListData({required String userID});
}

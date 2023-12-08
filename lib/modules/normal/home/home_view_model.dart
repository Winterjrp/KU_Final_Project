import 'package:untitled1/modules/normal/home/models/home_model.dart';
import 'package:untitled1/services/home_services/home_mock_service.dart';
import 'package:untitled1/services/home_services/home_service_interface.dart';

class HomeViewModel {
  late HomeServiceInterface services;
  late Future<HomeModel> homeDataFetch;
  late HomeModel homeData;

  HomeViewModel() {
    services = HomeMockService();
  }

  Future<HomeModel> getHomeData({required String userID}) async {
    homeDataFetch = services.getPetListData(userID: userID);
    homeData = await homeDataFetch;
    return homeDataFetch;
  }
}

import 'package:untitled1/modules/admin/admin_add_pet_info/models/admin_home_model.dart';

abstract class AdminHomeServiceInterface {
  Future<AdminHomeModel> getAdminHomeData();
}

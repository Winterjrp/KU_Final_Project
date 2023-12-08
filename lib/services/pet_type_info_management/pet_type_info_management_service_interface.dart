import 'package:untitled1/hive_models/pet_type_info_model.dart';

abstract class PetTypeInfoManagementServiceInterface {
  Future<List<PetTypeInfoModel>> getPetTypeInfoData();
  Future<void> deletePetTypeInfo({required String petTypeInfoID});
}

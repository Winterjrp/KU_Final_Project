import 'package:hive/hive.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/services/pet_type_info_management/pet_type_info_management_service_interface.dart';

class PetTypeInfoManagementMockService
    implements PetTypeInfoManagementServiceInterface {
  @override
  Future<List<PetTypeInfoModel>> getPetTypeInfoData() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    final petTypeInfoListBox =
        await Hive.openBox<PetTypeInfoModel>('petTypeInfoListBox');
    List<PetTypeInfoModel> petTypeInfoListData =
        petTypeInfoListBox.values.toList();
    return petTypeInfoListData;
  }

  @override
  Future<void> deletePetTypeInfo({required String petTypeInfoID}) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Box petTypeInfoListBox = Hive.box<PetTypeInfoModel>('petTypeInfoListBox');
    await petTypeInfoListBox.delete(petTypeInfoID);
  }
}

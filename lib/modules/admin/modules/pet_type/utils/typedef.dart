import 'package:untitled1/utility/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/utility/hive_models/pet_physiological_nutrient_limit_model.dart';

typedef OnUserAddPetPhysiologicalCallBackFunction = void Function({
  required List<NutrientLimitInfoModel> nutrientLimitInfo,
  required String petPhysiologicalId,
  required String petPhysiologicalName,
  required String petType,
  required String petTypeId,
  required String description,
});

typedef OnUserDeletePetPhysiologicalCallBackFunction = void Function(
    {required PetPhysiologicalModel petPhysiologicalData});

typedef OnUserEditPetPhysiologicalCallBackFunction = void Function();

import 'package:flutter/material.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/ingredient_info/ingredient_info_view.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

// typedef DeletePetInfoCallBack = void Function({required String petID});

class IngredientInfoCard extends StatelessWidget {
  const IngredientInfoCard({
    required this.context,
    required this.index,
    required this.ingredientList,
    // required this.viewModel,
    required this.userInfo,
    // required this.deletePetInfoCallBack,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final int index;
  // final IngredientManagementViewModel viewModel;
  final UserInfoModel userInfo;
  final List<IngredientModel> ingredientList;

  // final DeletePetInfoCallBack deletePetInfoCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey.shade200),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IngredientInfoView(
                      userInfo: userInfo,
                      ingredientInfo: ingredientList[index],
                      nutrientListLength: ingredientList[index].nutrient.length,
                    )),
          );
        },
        child: Text(ingredientList[index].ingredientName,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }
}

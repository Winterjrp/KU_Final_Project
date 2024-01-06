import 'package:flutter/material.dart';
import 'package:untitled1/modules/admin/recipes_info/recipe_info_view.dart';
import 'package:untitled1/modules/admin/recipes_management/recipes_management_view_model.dart';

class RecipesManagementCard extends StatelessWidget {
  final BuildContext context;
  final int index;
  final RecipesManagementViewModel viewModel;

  const RecipesManagementCard({
    required this.context,
    required this.index,
    required this.viewModel,
    // required this.deletePetInfoCallBack,
    Key? key,
  }) : super(key: key);

  // final DeletePetInfoCallBack deletePetInfoCallBack;

  @override
  Widget build(BuildContext context) {
    void onUserDeleteRecipe({required String recipeID}) {
      viewModel.onUserDeleteRecipe(recipeID: recipeID);
    }

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
                builder: (context) => RecipesInfoView(
                    recipesData: viewModel.recipesList[index],
                    deleteRecipesCallBack: onUserDeleteRecipe)),
          );
        },
        child: Text(viewModel.recipesList[index].recipesName,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }
}

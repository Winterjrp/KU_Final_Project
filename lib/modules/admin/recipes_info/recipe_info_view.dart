import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/edit_recipes/edit_recipe_view.dart';
import 'package:untitled1/modules/admin/recipes_info/widgets/delete_recipes_confirm_popup.dart';
import 'package:untitled1/modules/admin/recipes_info/widgets/nutrient_info_table_cell.dart';
import 'package:untitled1/modules/admin/recipes_info/widgets/recipes_info_table_cell.dart';

typedef DeleteRecipesCallBack = void Function({required String recipeID});

class RecipesInfoView extends StatelessWidget {
  final UserInfoModel userInfo;
  final RecipesModel recipesData;
  final DeleteRecipesCallBack deleteRecipesCallBack;

  RecipesInfoView(
      {required this.userInfo,
      required this.recipesData,
      required this.deleteRecipesCallBack,
      Key? key})
      : super(key: key);

  late String _recipesName;
  late String _petTypeName;
  final Map<int, TableColumnWidth> _tableColumnWidth =
      const <int, TableColumnWidth>{
    0: FlexColumnWidth(0.2),
    1: FlexColumnWidth(0.8),
    2: FlexColumnWidth(0.3),
  };
  final double _tableHeaderPadding = 20;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    _recipesName = recipesData.recipesName;
    _petTypeName = recipesData.petTypeName;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            Row(
              children: [
                const Spacer(),
                _editRecipeInfoButton(context: context),
                const SizedBox(width: 15),
                _deleteRecipeInfoButton(context: context),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  _ingredient(width),
                  const SizedBox(width: 30),
                  _nutrient(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deleteRecipeInfoButton({required BuildContext context}) {
    // IngredientInfoViewModel viewModel = IngredientInfoViewModel();
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return DeleteRecipesConfirmPopup(
                userInfo: userInfo,
                recipeID: recipesData.recipesID,
                deleteRecipesCallBack: deleteRecipesCallBack,
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.delete_rounded, color: Colors.white),
            SizedBox(width: 5),
            Text('ลบข้อมูล',
                style: TextStyle(fontSize: 17, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _editRecipeInfoButton({required BuildContext context}) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditRecipesView(
                    userInfo: userInfo, recipeData: recipesData)),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 10),
            Text('แก้ไข', style: TextStyle(fontSize: 17, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Expanded _nutrient(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "สารอาหาร",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _nutrientTable(),
        ],
      ),
    );
  }

  Widget _nutrientTable() {
    return Expanded(
      child: Column(
        children: [
          _nutrientTableHeader(),
          _nutrientTableBody(),
        ],
      ),
    );
  }

  Widget _nutrientTableHeader() {
    return Table(
      columnWidths: _tableColumnWidth,
      border: TableBorder.symmetric(
        inside: const BorderSide(
          width: 1,
          // color: primary,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: primary,
            border: Border.all(
              width: 1,
              // color: primary,
            ),
            // color: kColorLightBlueBTN,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'ลำดับที่',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'สารอาหาร',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'ปริมาณสารอาหาร',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _nutrientTableBody() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
            left: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
            right: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
          ),
        ),
        child: ListView.builder(
          itemCount: recipesData.nutrient.length,
          itemBuilder: (context, index) {
            return NutrientInfoTableCell(
              index: index,
              tableColumnWidth: _tableColumnWidth,
              nutrientInfo: recipesData.nutrient[index],
            );
          },
        ),
      ),
    );
  }

  SizedBox _ingredient(double width) {
    return SizedBox(
      width: 0.43 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "วัตถุดิบ",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _ingredientTable(),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        const Text(
          "ข้อมูลสูตรอาหาร:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45,
            // color: kPrimaryDarkColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          _recipesName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45,
            // color: kPrimaryDarkColor,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          "ของ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45,
            // color: kPrimaryDarkColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          _petTypeName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45,
            // color: kPrimaryDarkColor,
          ),
        ),
      ],
    );
  }

  Widget _ingredientTable() {
    return Expanded(
      child: Column(
        children: [
          _ingredientTableHeader(),
          _ingredientTableBody(),
        ],
      ),
    );
  }

  Widget _ingredientTableHeader() {
    return Table(
      columnWidths: _tableColumnWidth,
      border: TableBorder.symmetric(
        inside: const BorderSide(
          width: 1,
          // color: primary,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: primary,
            border: Border.all(
              width: 1,
              // color: primary,
            ),
            // color: kColorLightBlueBTN,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'ลำดับที่',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'วัตถุดิบ',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: const Center(
                  child: Text(
                    'ปริมาณวัตถุดิบ',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ingredientTableBody() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
            left: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
            right: BorderSide(
              width: 0.9,
              color: lightGrey,
            ),
          ),
        ),
        child: ListView.builder(
          itemCount: recipesData.ingredientInRecipes.length,
          itemBuilder: (context, index) {
            return RecipesInfoTableCell(
              index: index,
              tableColumnWidth: _tableColumnWidth,
              ingredientInRecipesList: recipesData.ingredientInRecipes,
            );
          },
        ),
      ),
    );
  }
}

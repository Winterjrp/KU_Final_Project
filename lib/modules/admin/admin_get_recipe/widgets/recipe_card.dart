import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/constants/size.dart';
import 'package:untitled1/modules/admin/admin_get_recipe/get_recipe_model.dart';
import 'package:untitled1/modules/admin/recipes_info/widgets/nutrient_info_table_cell.dart';
import 'package:untitled1/modules/admin/recipes_info/widgets/recipes_info_table_cell.dart';

class RecipeCard extends StatelessWidget {
  final SearchPetRecipeModel searchPetRecipeData;

  const RecipeCard({
    required this.searchPetRecipeData,
    Key? key,
  }) : super(key: key);

  static const Map<int, TableColumnWidth> _nutrientTableColumnWidth =
      <int, TableColumnWidth>{
    0: FlexColumnWidth(0.2),
    1: FlexColumnWidth(0.6),
    2: FlexColumnWidth(0.4),
    3: FlexColumnWidth(0.3),
  };
  static const _ingredientTableColumnWidth = <int, TableColumnWidth>{
    0: FlexColumnWidth(0.2),
    1: FlexColumnWidth(0.4),
    2: FlexColumnWidth(0.35),
  };
  static const double _tableHeaderPadding = 12;
  static const TextStyle _headerTextStyle =
      TextStyle(fontSize: 17, color: specialBlack);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    return Container(
      height: 800,
      color: Colors.white,
      child: _body(context, width),
    );
  }

  Center _body(BuildContext context, double width) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        constraints: const BoxConstraints(maxWidth: adminScreenMaxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            _header(),
            Expanded(
              child: Column(
                children: [
                  _ingredient(width),
                  // const SizedBox(width: 30),
                  // _nutrient(context),
                ],
              ),
            ),
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
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
      columnWidths: _nutrientTableColumnWidth,
      border: TableBorder.symmetric(
        inside: const BorderSide(
          width: 1,
        ),
      ),
      children: const [
        TableRow(
          decoration: BoxDecoration(
            color: specialBlack,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ลำดับที่',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'สารอาหาร',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ปริมาณสารอาหาร (%FM)',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'หน่วย',
                    style: _headerTextStyle,
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
        decoration: const BoxDecoration(
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
          itemCount: searchPetRecipeData.recipeData.freshNutrientList.length,
          itemBuilder: (context, index) {
            return NutrientInfoTableCell(
              index: index,
              tableColumnWidth: _nutrientTableColumnWidth,
              nutrientInfo:
                  searchPetRecipeData.recipeData.freshNutrientList[index],
            );
          },
        ),
      ),
    );
  }

  Widget _ingredient(double width) {
    return SizedBox(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "วัตถุดิบ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
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
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          searchPetRecipeData.recipeData.recipeName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: const Text(
            "ของ",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          searchPetRecipeData.recipeData.petTypeName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
      columnWidths: _ingredientTableColumnWidth,
      children: const [
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black, // specify your color here
                width: 1.0, // specify your width here
              ),
              bottom: BorderSide(
                color: Colors.black, // specify your color here
                width: 1.0, // specify your width here
              ),
            ),
            // color: specialBlack,
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(15),
            //   topRight: Radius.circular(15),
            // ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ลำดับที่',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'วัตถุดิบ',
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(_tableHeaderPadding),
                child: Center(
                  child: Text(
                    'ปริมาณวัตถุดิบ (%)',
                    style: _headerTextStyle,
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
        decoration: BoxDecoration(gradient: tableBackGroundGradient),
        child: ListView.builder(
          itemCount:
              searchPetRecipeData.recipeData.ingredientInRecipeList.length,
          itemBuilder: (context, index) {
            return RecipesInfoTableCell(
              index: index,
              tableColumnWidth: _ingredientTableColumnWidth,
              ingredientInRecipesList:
                  searchPetRecipeData.recipeData.ingredientInRecipeList,
            );
          },
        ),
      ),
    );
  }
}

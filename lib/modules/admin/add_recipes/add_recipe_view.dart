import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/add_recipes/add_recipes_view_model.dart';
import 'package:untitled1/modules/admin/add_recipes/widgets/add_recipes_cancel_popup.dart';
import 'package:untitled1/modules/admin/add_recipes/widgets/add_recipes_confirm_popup.dart';
import 'package:untitled1/modules/admin/add_recipes/widgets/add_recipes_table_cell.dart';
import 'package:untitled1/modules/admin/add_recipes/widgets/nutrient_table_cell.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

class AddRecipesView extends StatefulWidget {
  const AddRecipesView({required this.userInfo, Key? key}) : super(key: key);

  final UserInfoModel userInfo;
  @override
  State<AddRecipesView> createState() => _AddRecipesViewState();
}

class _AddRecipesViewState extends State<AddRecipesView> {
  late AddRecipesViewModel _viewModel;
  late TextEditingController _recipesNameController;
  late String _petTypeName;
  final Map<int, TableColumnWidth> _tableColumnWidth =
      const <int, TableColumnWidth>{
    0: FlexColumnWidth(0.2),
    1: FlexColumnWidth(0.9),
    2: FlexColumnWidth(0.35),
    3: FlexColumnWidth(0.15),
  };
  final double _tableHeaderPadding = 20;

  @override
  void initState() {
    super.initState();
    _viewModel = AddRecipesViewModel();
    _recipesNameController = TextEditingController();
    _viewModel.getIngredientData();
    _viewModel.getPetTypeListData();
    _petTypeName = "";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddRecipesCancelPopup();
            });
        return confirm;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: FutureBuilder<List<IngredientModel>>(
            future: _viewModel.ingredientListData,
            builder: (context, AsyncSnapshot<List<IngredientModel>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return _loadingScreen();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      const SizedBox(height: 5),
                      _recipesName(),
                      const SizedBox(height: 5),
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
                );
              }
              return const Text('No data available');
            }),
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
          const SizedBox(height: 20),
          _acceptButton(context),
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
          itemCount: _viewModel.nutrientList.length,
          itemBuilder: (context, index) {
            return NutrientTableCell(
              index: index,
              tableColumnWidth: _tableColumnWidth,
              nutrientInfo: _viewModel.nutrientList[index],
            );
          },
        ),
      ),
    );
  }

  SizedBox _ingredient(double width) {
    return SizedBox(
      width: 0.48 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "วัตถุดิบ",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _ingredientTable(),
          const SizedBox(height: 10),
          _addIngredientButton()
        ],
      ),
    );
  }

  Widget _loadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3.5,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "กำลังโหลดข้อมูล กรุณารอสักครู่...",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Row _acceptButton(BuildContext context) {
    void onUserAddRecipesCallBack() {
      _viewModel.onUserAddRecipes(
          recipesID: Random().nextInt(999).toString(),
          recipesName: _recipesNameController.text,
          petTypeName: _petTypeName);
    }

    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AddRecipesConfirmPopup(
                    userInfo: widget.userInfo,
                    addRecipesCallBack: onUserAddRecipesCallBack,
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(58, 180, 106, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('ตกลง', style: TextStyle(fontSize: 17)),
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return const SizedBox(
      child: Text(
        "เพิ่มข้อมูลสูตรอาหาร",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 45,
          // color: kPrimaryDarkColor,
        ),
      ),
    );
  }

  Widget _recipesName() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 50,
          width: 500,
          child: TextField(
            controller: _recipesNameController,
            style: const TextStyle(fontSize: 17),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: "ชื่อสูตรอาหาร",
              labelStyle: const TextStyle(fontSize: 19),
              contentPadding: const EdgeInsets.only(left: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: tGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: tGrey),
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 15),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            "ของ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              // color: kPrimaryDarkColor,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 350,
          margin: const EdgeInsets.only(top: 10),
          child: DropdownSearch<PetTypeInfoModel>(
            dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: const TextStyle(fontSize: 19),
                dropdownSearchDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "ชนิดสัตว์เลี้ยง",
                  labelStyle: const TextStyle(fontSize: 19),
                  contentPadding: const EdgeInsets.only(left: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: tGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: tGrey),
                  ),
                )),
            items: _viewModel.petTypeList,
            onChanged: (value) {
              if (value != null) {
                _petTypeName = value.petTypeName;
              }

              // setState(() {
              //   _petPhysiologyStatus = value!;
              // });
            },
            itemAsString: (PetTypeInfoModel? item) {
              return item?.petTypeName ?? "";
            },
          ),
        )
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

  Padding _addIngredientButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () async {
              _viewModel.onUserAddIngredient();
              setState(() {});
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, size: 50),
                Text(
                  " เพิ่มวัตถุดิบ",
                  style: TextStyle(fontSize: 16),
                )
              ],
            )),
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
            const TableCell(
              child: SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ingredientTableBody() {
    Future<void> ingredientDelete({required int index}) async {
      await _viewModel.onUserDeleteIngredient(index: index);
      setState(() {});
    }

    void onUserSelectAmountCallback(
        {required double amountData, required int index}) {
      setState(() {
        _viewModel.onUserSelectAmount(amountData: amountData, index: index);
      });
    }

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
          itemCount: _viewModel.ingredientInRecipes.length,
          itemBuilder: (context, index) {
            return AddRecipesTableCell(
              index: index,
              tableColumnWidth: _tableColumnWidth,
              // ingredientAmountChangeCallback: ingredientAmountChange,
              ingredientList: _viewModel.ingredientInChoice,
              viewModel: _viewModel,
              ingredientDeleteCallback: ingredientDelete,
              onUserSelectAmount: onUserSelectAmountCallback,
            );
          },
        ),
      ),
    );
  }
}

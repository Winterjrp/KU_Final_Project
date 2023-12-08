import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/edit_ingredient/edit_ingredient_view.dart';
import 'package:untitled1/modules/admin/ingredient_info/ingredient_info_view_model.dart';
import 'package:untitled1/modules/admin/ingredient_info/widgets/delete_ingredient_confirm_popup.dart';
import 'package:untitled1/modules/admin/ingredient_info/widgets/ingredient_info_table_cell.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

class IngredientInfoView extends StatelessWidget {
  const IngredientInfoView({
    required this.userInfo,
    required this.ingredientInfo,
    required this.nutrientListLength,
    Key? key,
  }) : super(key: key);

  final UserInfoModel userInfo;
  final double _tableHeaderPadding = 20;
  final IngredientModel ingredientInfo;
  final int nutrientListLength;

  final Map<int, TableColumnWidth> _tableColumnWidth =
      const <int, TableColumnWidth>{
    0: FlexColumnWidth(0.1),
    1: FlexColumnWidth(0.5),
    2: FlexColumnWidth(0.2),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _operationButton(context: context),
            const SizedBox(height: 15),
            _table(),
          ],
        ),
      ),
    );
  }

  Row _operationButton({required BuildContext context}) {
    return Row(
      children: [
        const Spacer(),
        _editIngredientInfoButton(context: context),
        const SizedBox(width: 15),
        _deleteIngredientInfoButton(context: context),
      ],
    );
  }

  Widget _deleteIngredientInfoButton({required BuildContext context}) {
    IngredientInfoViewModel viewModel = IngredientInfoViewModel();
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return DeleteIngredientConfirmPopup(
                viewModel: viewModel,
                userInfo: userInfo,
                ingredientID: ingredientInfo.ingredientID,
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

  Widget _editIngredientInfoButton({required BuildContext context}) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditIngredientView(
                        userInfo: userInfo,
                        ingredientInfo: ingredientInfo,
                      )));
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

  Widget _header() {
    return Text(
      "ข้อมูลวัตถุดิบ: ${ingredientInfo.ingredientName}",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 42,
        // color: kPrimaryDarkColor,
      ),
    );
  }

  Widget _table() {
    return Expanded(
      child: Column(
        children: [
          _tableHeader(),
          _tableBody(),
        ],
      ),
    );
  }

  Widget _tableHeader() {
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

  Widget _tableBody() {
    // void onShopGroupRemove(String shopGroupID) {
    //   setState(() {
    //     onUserDeleteShopGroup(shopGroupID);
    //   });
    // }

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
          itemCount: nutrientListLength,
          itemBuilder: (context, index) {
            return IngredientInfoTableCell(
              index: index,
              tableColumnWidth: _tableColumnWidth,
              nutrientInfo: ingredientInfo.nutrient[index],
            );
          },
        ),
      ),
    );
  }
}

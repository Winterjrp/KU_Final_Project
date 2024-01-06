import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/modules/admin/ingredient_info/ingredient_info_view_model.dart';
import 'package:untitled1/modules/admin/ingredient_info/widgets/ingredient_info_table_cell.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/modules/admin/ingredient_management/ingredient_management_view.dart';
import 'package:untitled1/modules/admin/update_ingredient/update_ingredient_view.dart';
import 'package:untitled1/modules/admin/widgets/admin_loading_screen.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_delete_confirm_popup.dart';
import 'package:untitled1/modules/admin/widgets/popup/admin_success_popup.dart';
import 'package:untitled1/utility/navigation_with_animation.dart';

class IngredientInfoView extends StatelessWidget {
  IngredientInfoView({
    required this.ingredientInfo,
    Key? key,
  }) : super(key: key);

  final double _tableHeaderPadding = 12;
  final IngredientModel ingredientInfo;
  final Map<int, TableColumnWidth> _tableColumnWidth =
      const <int, TableColumnWidth>{
    0: FlexColumnWidth(0.1),
    1: FlexColumnWidth(0.5),
    2: FlexColumnWidth(0.2),
  };
  final TextStyle _headerTextStyle =
      const TextStyle(fontSize: 17, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _routingGuide(),
            const SizedBox(height: 5),
            _header(),
            _operationButton(context: context),
            const SizedBox(height: 15),
            _table(),
          ],
        ),
      ),
    );
  }

  Text _routingGuide() {
    return const Text(
      "จัดการข้อมูลวัตถุดิบ / ข้อมูลวัตถุดิบ",
      style: TextStyle(color: Colors.grey, fontSize: 20),
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

  BuildContext? storedContext;

  Future<void> _handleDeleteIngredient() async {
    if (storedContext == null) {
      return;
    }

    Navigator.pop(storedContext!);
    showDialog(
        barrierDismissible: false,
        context: storedContext!,
        builder: (context) {
          return const Center(child: AdminLoadingScreen());
        });
    try {
      IngredientInfoViewModel viewModel = IngredientInfoViewModel();
      await viewModel.onUserDeleteIngredientInfo(
          ingredientID: ingredientInfo.ingredientID);
      if (!storedContext!.mounted) return;
      Navigator.pop(storedContext!);
      Future.delayed(const Duration(milliseconds: 1800), () {
        Navigator.of(storedContext!).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
          storedContext!,
          NavigationDownward(
            targetPage: const IngredientManagementView(),
          ),
        );
      });
      AdminSuccessPopup(
              context: storedContext!, successText: 'ลบข้อมูลวัตถุดิบสำเร็จ!!')
          .show();
    } catch (e) {
      print(e);
    }
  }

  Widget _deleteIngredientInfoButton({required BuildContext context}) {
    storedContext = context;
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          AdminDeleteConfirmPopup(
            context: context,
            deleteText: 'ยืนยันการลบข้อมูลวัตถุดิบ?',
            callback: _handleDeleteIngredient,
          ).show();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.delete_forever_outlined, color: Colors.white),
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
            NavigationUpward(
              targetPage: UpdateIngredientView(
                ingredientInfo: ingredientInfo,
                isCreate: false,
              ),
              durationInMilliSec: 450,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: const Color.fromRGBO(252, 135, 119, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 10),
            Text('แก้ไขข้อมูล',
                style: TextStyle(fontSize: 17, color: Colors.white)),
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
        fontSize: 36,
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
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(16, 16, 29, 1),
            border: Border.all(
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
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
                    'ปริมาณสารอาหาร',
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
          itemCount: ingredientInfo.nutrient.length,
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

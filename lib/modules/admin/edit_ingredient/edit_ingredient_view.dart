import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/models/user_info_model.dart';
import 'package:untitled1/modules/admin/edit_ingredient/edit_ingredient_view_model.dart';
import 'package:untitled1/modules/admin/edit_ingredient/widgets/edit_ingredient_cancel_popup.dart';
import 'package:untitled1/modules/admin/edit_ingredient/widgets/edit_ingredient_confirm_popup.dart';
import 'package:untitled1/modules/admin/edit_ingredient/widgets/edit_ingredient_table_cell.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

class EditIngredientView extends StatefulWidget {
  const EditIngredientView(
      {required this.userInfo, required this.ingredientInfo, Key? key})
      : super(key: key);

  final UserInfoModel userInfo;
  final IngredientModel ingredientInfo;

  @override
  State<EditIngredientView> createState() => _EditIngredientViewState();
}

class _EditIngredientViewState extends State<EditIngredientView> {
  late List<NutrientModel> temp;
  late EditIngredientViewModel _viewModel;
  late TextEditingController _ingredientNameController;
  final Map<int, TableColumnWidth> _tableColumnWidth =
      const <int, TableColumnWidth>{
    0: FlexColumnWidth(0.1),
    1: FlexColumnWidth(0.9),
    2: FlexColumnWidth(0.2),
  };
  final double _tableHeaderPadding = 20;

  @override
  void initState() {
    super.initState();
    temp = List.from(widget.ingredientInfo.nutrient);
    _viewModel = EditIngredientViewModel();
    _viewModel.getIngredientData(nutrientListData: temp);
    _ingredientNameController = TextEditingController();
    _ingredientNameController.text = widget.ingredientInfo.ingredientName;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const EditIngredientCancelPopup();
          },
        );
        return confirm;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _ingredientName(),
              const SizedBox(height: 15),
              _table(),
              const SizedBox(height: 20),
              _acceptButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _acceptButton(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 60,
          width: 200,
          child: ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return EditIngredientConfirmPopup(
                    viewModel: _viewModel,
                    userInfo: widget.userInfo,
                    ingredientName: _ingredientNameController.text,
                    ingredientID: widget.ingredientInfo.ingredientID,
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
        "เเก้ไขข้อมูลวัตถุดิบ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 42,
          // color: kPrimaryDarkColor,
        ),
      ),
    );
  }

  Widget _ingredientName() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: 500,
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        controller: _ingredientNameController,
        style: const TextStyle(fontSize: 17),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "ชื่อวัตถุดิบ",
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
          _ingredientNameController.text = value;
        },
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
    void ingredientAmountChange({required int index, required double amount}) {
      setState(() {
        _viewModel.nutrientList[index].amount = amount;
      });
    }

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
                  return EditIngredientTableCell(
                    index: index,
                    tableColumnWidth: _tableColumnWidth,
                    nutrientAmount:
                        widget.ingredientInfo.nutrient[index].amount,
                    ingredientAmountChangeCallback: ingredientAmountChange,
                    viewModel: _viewModel,
                  );
                })));
  }
}

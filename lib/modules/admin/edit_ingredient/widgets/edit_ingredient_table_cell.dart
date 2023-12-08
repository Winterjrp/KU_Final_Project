import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/modules/admin/edit_ingredient/edit_ingredient_view_model.dart';

// typedef OnShopGroupRemoveCallback = void Function(String shopGroupID);
typedef IngredientAmountChangeCallback = void Function(
    {required int index, required double amount});

class EditIngredientTableCell extends StatefulWidget {
  const EditIngredientTableCell({
    Key? key,
    required this.index,
    required this.tableColumnWidth,
    required this.nutrientAmount,
    required this.ingredientAmountChangeCallback,
    required this.viewModel,
  }) : super(key: key);

  final int index;
  final double nutrientAmount;
  final Map<int, TableColumnWidth> tableColumnWidth;
  final IngredientAmountChangeCallback ingredientAmountChangeCallback;
  final EditIngredientViewModel viewModel;

  @override
  State<EditIngredientTableCell> createState() =>
      _EditIngredientTableCellState();
}

class _EditIngredientTableCellState extends State<EditIngredientTableCell> {
  late TextEditingController _nutrientAmountController;

  @override
  void initState() {
    super.initState();
    _nutrientAmountController = TextEditingController();

    _nutrientAmountController.text = widget.nutrientAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: widget.tableColumnWidth,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: lightGrey,
              ),
            ),
          ),
          children: [
            _number(),
            _nutrient(),
            _amount(),
          ],
        ),
      ],
    );
  }

  TableCell _number() {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Center(
          child: Text(
            (widget.index + 1).toString(),
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }

  TableCell _nutrient() {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Text(
          widget.viewModel.nutrientList[widget.index].nutrientName,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  TableCell _amount() {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 50,
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            onTap: () {
              _nutrientAmountController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _nutrientAmountController.text.length,
              );
            },
            controller: _nutrientAmountController,
            style: const TextStyle(fontSize: 17),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "ปริมาณสารอาหาร",
              hintStyle: const TextStyle(fontSize: 17),
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
              widget.ingredientAmountChangeCallback(
                  index: widget.index, amount: double.parse(value));
            },
          ),
        ),
      ),
    );
  }
}

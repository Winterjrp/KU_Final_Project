import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/modules/admin/add_recipes/add_recipes_view_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

typedef IngredientDeleteCallback = void Function({required int index});
typedef OnUserSelectAmountCallback = void Function(
    {required double amountData, required int index});

class AddRecipesTableCell extends StatefulWidget {
  final int index;
  final Map<int, TableColumnWidth> tableColumnWidth;
  final IngredientDeleteCallback ingredientDeleteCallback;
  final List<IngredientModel> ingredientList;
  final AddRecipesViewModel viewModel;
  final OnUserSelectAmountCallback onUserSelectAmount;
  const AddRecipesTableCell({
    Key? key,
    required this.index,
    required this.tableColumnWidth,
    required this.ingredientDeleteCallback,
    required this.ingredientList,
    required this.viewModel,
    required this.onUserSelectAmount,
  }) : super(key: key);

  @override
  State<AddRecipesTableCell> createState() => _AddRecipesTableCellState();
}

class _AddRecipesTableCellState extends State<AddRecipesTableCell> {
  late TextEditingController _nutrientAmountController;

  @override
  void initState() {
    super.initState();
    _nutrientAmountController = TextEditingController();
    _nutrientAmountController.text = "0.0";
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: widget.tableColumnWidth,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: widget.index % 2 == 1 ? Colors.white : Colors.grey.shade100,
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
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: IconButton(
                  splashRadius: 5,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    widget.ingredientDeleteCallback(index: widget.index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
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

  Widget _nutrient() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      width: 100,
      child: DropdownSearch<IngredientModel>(
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: const TextStyle(fontSize: 17),
            dropdownSearchDecoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "เลือกวัตถุดิบ",
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
            )),
        items: widget.ingredientList,
        onChanged: (value) {
          if (value != null) {
            widget.viewModel.onUserSelectIngredient(
                ingredientData: value, index: widget.index);
          }
        },
        itemAsString: (IngredientModel? item) {
          return item?.ingredientName ?? "";
        },
      ),
    );
  }

  TableCell _amount() {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
            widget.onUserSelectAmount(
                amountData: double.parse(value), index: widget.index);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/modules/admin/update_ingredient/update_ingredient_view_model.dart';

typedef MinAmountChangeCallback = void Function(
    {required int index, required double amount});

typedef MaxAmountChangeCallback = void Function(
    {required int index, required double amount});

class AddPetChronicDiseaseTableCell extends StatefulWidget {
  final int index;
  final Map<int, TableColumnWidth> tableColumnWidth;
  final MinAmountChangeCallback minAmountChangeCallback;
  final MaxAmountChangeCallback maxAmountChangeCallback;

  const AddPetChronicDiseaseTableCell({
    Key? key,
    required this.index,
    required this.tableColumnWidth,
    required this.minAmountChangeCallback,
    required this.maxAmountChangeCallback,
  }) : super(key: key);

  @override
  State<AddPetChronicDiseaseTableCell> createState() =>
      _AddPetChronicDiseaseTableCellState();
}

class _AddPetChronicDiseaseTableCellState
    extends State<AddPetChronicDiseaseTableCell> {
  late TextEditingController _maxAmountController;
  late TextEditingController _minAmountController;
  late UpdateIngredientViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _maxAmountController = TextEditingController();
    _minAmountController = TextEditingController();
    // _viewModel = AddIngredientViewModel();
    // _maxAmountController.text =
    //     _viewModel.nutrientList[widget.index].amount.toString();
    // _minAmountController.text =
    //     _viewModel.nutrientList[widget.index].amount.toString();
    _maxAmountController.text = "0";
    _minAmountController.text = "0";
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
            _min(),
            _max(),
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
          "",
          // _viewModel.nutrientList[widget.index].nutrientName,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  TableCell _min() {
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
              _minAmountController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _minAmountController.text.length,
              );
            },
            controller: _minAmountController,
            style: const TextStyle(fontSize: 17),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "min",
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
              widget.minAmountChangeCallback(
                  index: widget.index, amount: double.parse(value));
            },
          ),
        ),
      ),
    );
  }

  TableCell _max() {
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
              _maxAmountController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _maxAmountController.text.length,
              );
            },
            controller: _maxAmountController,
            style: const TextStyle(fontSize: 17),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "max",
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
              widget.maxAmountChangeCallback(
                  index: widget.index, amount: double.parse(value));
            },
          ),
        ),
      ),
    );
  }
}

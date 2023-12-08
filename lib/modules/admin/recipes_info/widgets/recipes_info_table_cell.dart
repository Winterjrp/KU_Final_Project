import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/ingredient_in_recipes_model.dart';
import 'package:untitled1/modules/admin/add_recipes/add_recipes_view_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

// typedef IngredientDeleteCallback = void Function({required int index});
// typedef OnUserSelectAmountCallback = void Function(
//     {required double amountData, required int index});

class RecipesInfoTableCell extends StatefulWidget {
  final int index;
  final Map<int, TableColumnWidth> tableColumnWidth;
  // final IngredientDeleteCallback ingredientDeleteCallback;
  final List<IngredientInRecipesModel> ingredientInRecipesList;
  // final OnUserSelectAmountCallback onUserSelectAmount;
  const RecipesInfoTableCell({
    Key? key,
    required this.index,
    required this.tableColumnWidth,
    // required this.ingredientDeleteCallback,
    required this.ingredientInRecipesList,
    // required this.onUserSelectAmount,
  }) : super(key: key);

  @override
  State<RecipesInfoTableCell> createState() => _RecipesInfoTableCellState();
}

class _RecipesInfoTableCellState extends State<RecipesInfoTableCell> {
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
            _ingredient(),
            _amount(),
          ],
        ),
      ],
    );
  }

  TableCell _number() {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            (widget.index + 1).toString(),
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }

  Widget _ingredient() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          widget
              .ingredientInRecipesList[widget.index].ingredient.ingredientName,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  Widget _amount() {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            widget.ingredientInRecipesList[widget.index].amount.toString(),
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}

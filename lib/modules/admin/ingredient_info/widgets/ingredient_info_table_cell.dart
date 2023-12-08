import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';

// typedef OnShopGroupRemoveCallback = void Function(String shopGroupID);
typedef IngredientAmountChangeCallback = void Function();

class IngredientInfoTableCell extends StatelessWidget {
  const IngredientInfoTableCell({
    Key? key,
    required this.index,
    required this.tableColumnWidth,
    required this.nutrientInfo,
  }) : super(key: key);

  final Map<int, TableColumnWidth> tableColumnWidth;
  final NutrientModel nutrientInfo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: tableColumnWidth,
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
            (index + 1).toString(),
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
          nutrientInfo.nutrientName,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  TableCell _amount() {
    return TableCell(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Center(
          child: Text(
            nutrientInfo.amount.toString(),
            style: const TextStyle(
              fontSize: 17,
              // color: kPrimaryDarkColor,
            ),
          ),
        ),
      ),
    );
  }
}

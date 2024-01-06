import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/modules/admin/ingredient_info/ingredient_info_view.dart';
import 'package:untitled1/utility/navigation_with_animation.dart';

typedef IngredientAmountChangeCallback = void Function(
    {required int index, required double amount});

class IngredientTableCell extends StatefulWidget {
  final int index;
  final Map<int, TableColumnWidth> tableColumnWidth;
  final IngredientModel ingredientInfo;
  const IngredientTableCell({
    Key? key,
    required this.index,
    required this.tableColumnWidth,
    required this.ingredientInfo,
  }) : super(key: key);

  @override
  State<IngredientTableCell> createState() => _IngredientTableCellState();
}

class _IngredientTableCellState extends State<IngredientTableCell> {
  final EdgeInsets _tableCellPaddingInset =
      const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10);
  late bool _isHovered;

  @override
  void initState() {
    super.initState();
    _isHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            NavigationUpward(
                targetPage: IngredientInfoView(
                  ingredientInfo: widget.ingredientInfo,
                ),
                durationInMilliSec: 300),
          );
        },
        child: Container(
          color: Colors.transparent,
          child: Table(
            columnWidths: widget.tableColumnWidth,
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: _isHovered
                      ? flesh.withOpacity(0.2)
                      : widget.index % 2 == 1
                          ? Colors.white
                          : Colors.grey.shade100,
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: lightGrey,
                    ),
                    left: BorderSide(
                      width: 1,
                      color: lightGrey,
                    ),
                    right: BorderSide(
                      width: 1,
                      color: lightGrey,
                    ),
                  ),
                ),
                children: [
                  _number(),
                  _ingredientId(),
                  _ingredientName(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableCell _number() {
    return TableCell(
      child: Padding(
        padding: _tableCellPaddingInset,
        child: Center(
          child: Text(
            (widget.index + 1).toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  TableCell _ingredientId() {
    return TableCell(
      child: Padding(
        padding: _tableCellPaddingInset,
        child: Center(
          child: Text(
            widget.ingredientInfo.ingredientID,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  TableCell _ingredientName() {
    return TableCell(
      child: Padding(
        padding: _tableCellPaddingInset,
        child: Text(
          widget.ingredientInfo.ingredientName,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled1/constants/color.dart';
import 'package:untitled1/modules/admin/modules/pet_type/utils/typedef.dart';
import 'package:untitled1/modules/admin/pet_physiological_info/pet_physiological_info_view.dart';
import 'package:untitled1/utility/hive_models/pet_physiological_nutrient_limit_model.dart';
import 'package:untitled1/utility/navigation_with_animation.dart';

typedef OnUserEditPetChronicDiseaseCallBackFunction = void Function(
    {required String petChronicDiseaseId});

class PetPhysiologicalTableCell extends StatefulWidget {
  final PetPhysiologicalModel petPhysiologicalInfo;
  final int index;
  final Map<int, TableColumnWidth> tableColumnWidth;
  // final String petTypeName;
  final OnUserDeletePetPhysiologicalCallBackFunction
      onUserDeletePetPhysiologicalCallBack;
  final OnUserAddPetPhysiologicalCallBackFunction
      onUserAddPetPhysiologicalCallBack;
  final OnUserEditPetChronicDiseaseCallBackFunction
      onUserEditPetChronicDiseaseCallBack;
  const PetPhysiologicalTableCell({
    Key? key,
    required this.index,
    required this.tableColumnWidth,
    required this.petPhysiologicalInfo,
    // required this.petTypeName,
    required this.onUserDeletePetPhysiologicalCallBack,
    required this.onUserAddPetPhysiologicalCallBack,
    required this.onUserEditPetChronicDiseaseCallBack,
  }) : super(key: key);

  @override
  State<PetPhysiologicalTableCell> createState() =>
      _PetPhysiologicalTableCellState();
}

class _PetPhysiologicalTableCellState extends State<PetPhysiologicalTableCell> {
  static const EdgeInsets _tableCellPaddingInset =
      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10);
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
                targetPage: PetPhysiologicalInfoView(
                  petPhysiologicalInfo: widget.petPhysiologicalInfo,
                  petTypeName: widget.petPhysiologicalInfo.petTypeName,
                  onUserDeletePetPhysiologicalCallBack:
                      widget.onUserDeletePetPhysiologicalCallBack,
                  onUserAddPetPhysiologicalCallBack:
                      widget.onUserAddPetPhysiologicalCallBack,
                  onUserEditPetChronicDiseaseCallBack:
                      widget.onUserEditPetChronicDiseaseCallBack,
                ),
                durationInMilliSec: 700),
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
                      ? flesh
                      : widget.index % 2 == 1
                          ? Colors.white
                          : Colors.grey.shade100,
                ),
                children: [
                  _number(),
                  _petChronicDiseaseId(),
                  _petChronicDiseaseName(),
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

  TableCell _petChronicDiseaseId() {
    return TableCell(
      child: Padding(
        padding: _tableCellPaddingInset,
        child: Center(
          child: Text(
            widget.petPhysiologicalInfo.petPhysiologicalId,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  TableCell _petChronicDiseaseName() {
    return TableCell(
      child: Padding(
        padding: _tableCellPaddingInset,
        child: Text(
          widget.petPhysiologicalInfo.petPhysiologicalName,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

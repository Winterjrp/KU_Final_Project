import 'package:flutter/material.dart';
import 'package:untitled1/modules/admin/pet_type_info/pet_type_info_view.dart';
import 'package:untitled1/modules/admin/pet_type_info_management/pet_type_info_management_view_model.dart';

typedef DeletePetTypeInfoCallBack = void Function(
    {required String petTypeInfoID});

class PetTypeInfoManagementCard extends StatelessWidget {
  final DeletePetTypeInfoCallBack deletePetTypeInfoCallBack;
  final BuildContext context;
  final int index;
  final PetTypeInfoManagementViewModel viewModel;

  const PetTypeInfoManagementCard({
    required this.deletePetTypeInfoCallBack,
    required this.context,
    required this.index,
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey.shade200),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PetTypeInfoView(
                      petTypeInfo: viewModel.petTypeInfo[index],
                      deletePetTypeInfoCallBack: deletePetTypeInfoCallBack,
                    )),
          );
        },
        child: Text(viewModel.petTypeInfo[index].petTypeName,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }
}

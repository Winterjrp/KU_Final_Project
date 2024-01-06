import 'package:flutter/material.dart';
import 'package:untitled1/modules/admin/update_pet_type_info/add_pet_type_info_view_model.dart';

class UpdatePetTypeInfoCard extends StatelessWidget {
  const UpdatePetTypeInfoCard({
    required this.context,
    required this.index,
    required this.viewModel,
    // required this.deletePetInfoCallBack,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final int index;
  final AddPetTypeInfoViewModel viewModel;
  // final DeletePetInfoCallBack deletePetInfoCallBack;

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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => PetProfileView(
          //             index: index,
          //             homeViewModel: viewModel,
          //             userInfo: userInfo,
          //           )),
          // );
        },
        child: Text(
            viewModel.petChronicDiseaseList[index].petChronicDiseaseName,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }
}

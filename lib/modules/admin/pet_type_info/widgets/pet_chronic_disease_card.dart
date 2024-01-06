import 'package:flutter/material.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';

class PetChronicDiseaseCard extends StatelessWidget {
  final BuildContext context;
  final int index;
  final PetChronicDiseaseModel petChronicDiseaseData;
  const PetChronicDiseaseCard({
    required this.context,
    required this.index,
    required this.petChronicDiseaseData,
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
        child: Text(petChronicDiseaseData.petChronicDiseaseName,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }
}

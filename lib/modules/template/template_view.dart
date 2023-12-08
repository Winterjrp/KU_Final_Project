import 'package:flutter/material.dart';

import '../../constants/color.dart';

class TemplateView extends StatefulWidget {
  const TemplateView({Key? key}) : super(key: key);

  @override
  State<TemplateView> createState() => _TemplateViewState();
}

class _TemplateViewState extends State<TemplateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [],
        ),
      ),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_outlined),
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (context) {
        //         return const AddPetProfileCancelPopup();
        //       },
        //     );
        //   },
        // ),
        title: const Center(child: Text("เพิ่มข้อมูลสัตว์เลี้ยง  ")),
        backgroundColor: primary,
      ),
    );
  }
}

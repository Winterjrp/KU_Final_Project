import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: rive.RiveAnimation.asset("assets/404_cat.riv")),
        ],
      ),
    );
  }
}

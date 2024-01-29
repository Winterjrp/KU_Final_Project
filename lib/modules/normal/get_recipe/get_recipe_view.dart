import 'package:flutter/material.dart';

class GetRecipeView extends StatefulWidget {
  const GetRecipeView({Key? key}) : super(key: key);

  @override
  State<GetRecipeView> createState() => _GetRecipeViewState();
}

class _GetRecipeViewState extends State<GetRecipeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(),
    );
  }
}

import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDropdown(context);
            },
            child: Text('Show Dropdown'),
          ),
        ),
      ),
    );
  }

  void showDropdown(BuildContext context) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy - 100, // Adjust the top position as needed
        left: offset.dx,
        child: Material(
          child: Container(
            height: 100,
            width: 150,
            color: Colors.white,
            child: const Center(
              child: Text('Dropdown Content'),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);

    // Wait for a short duration and remove the overlay entry
    await Future.delayed(const Duration(seconds: 2));

    overlayEntry.remove();
  }
}

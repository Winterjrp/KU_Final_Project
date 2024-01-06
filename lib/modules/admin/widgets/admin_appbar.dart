import 'package:flutter/material.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => // Ensure Scaffold is in context
            Container(
          margin: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      // title: const Center(child: Text("ฟังก์ชันสำหรับผู้ดูแลระบบ")),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}

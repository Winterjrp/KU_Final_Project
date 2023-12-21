import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(248, 249, 248, 1),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // const DrawerHeader(
                //   decoration: BoxDecoration(
                //     color: Colors.blue,
                //   ),
                //   child: Text(
                //     'Drawer Header',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 24,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Spacer(),
                    Icon(
                      Icons.menu_open,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    // Handle the tap on Home
                    // Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('จัดการผู้ใช้งาน'),
                  onTap: () {
                    // Handle the tap on Home
                    // Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('จัดการวัตุดิบ'),
                  onTap: () {
                    // Handle the tap on Home
                    // Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('จัดการสูตรอาหาร'),
                  onTap: () {
                    // Handle the tap on Settings
                    // Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text('จัดการชนิดสัตว์เลี้ยง'),
                  onTap: () {
                    // Handle the tap on Settings
                    // Navigator.pop(context); // Close the drawer
                  },
                ),

                // Add more ListTiles for additional items in the drawer
              ],
            ),
          ),
          Container(
            height: 100,
            color: const Color.fromRGBO(35, 34, 35, 1),
          )
        ],
      ),
    );
  }
}

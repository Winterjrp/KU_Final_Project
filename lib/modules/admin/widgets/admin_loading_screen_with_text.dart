import 'package:flutter/material.dart';

class AdminLoadingScreenWithText extends StatelessWidget {
  const AdminLoadingScreenWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "กำลังโหลดข้อมูล กรุณารอสักครู่...",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/theme/colors.dart';

class Utils {
  static void showLoader() {
    Get.dialog(
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: kColorPrimary,
            ),
            SizedBox(height: 16),
            Text("Loading..."),
          ],
        ),
      ),
      barrierDismissible: false, // Prevent dismissing with a tap outside
    );
  }
}

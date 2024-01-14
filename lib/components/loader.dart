import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

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

  static void showAlert() {
    Get.dialog(
      AlertDialog(
        content: Padding(
          padding: EdgeInsets.fromLTRB(16.h, 16.w, 16.h, 0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Please check your email for password reset instructions. \nIt's important to use your Google email to receive the reset details.",
                textAlign: TextAlign.center,
                style: kTextStyleGabaritoRegular.copyWith(
                  fontSize: 14.sp,
                  color: kColorGreyNeutral600,
                ),
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                child: Text(
                  'Okay',
                  style: kTextStyleGabaritoRegular.copyWith(
                    fontSize: 14.sp,
                    color: kColorWhite,
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      barrierDismissible: false, // Prevent dismissing with a tap outside
    );
  }
}

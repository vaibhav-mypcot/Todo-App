import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/const/const.dart';
import 'package:todo_app/theme/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.headingText,
  });

  final String? headingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.w),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 44.h,
                height: 44.h,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Const().backIC,
                    height: 32.h,
                    width: 32.h,
                  ),
                ),
              ),
            ),
          ),
          Text(
            headingText ?? "",
            style: TextStyle(
              fontSize: 18.sp,
              color: kColorBlackNeutral800,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

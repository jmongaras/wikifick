import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_colors.dart';

class SettingPopup {
  static Future<void> showSettingMenu(BuildContext context,{required Function(String) onItemSelected}) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: 60,
              right: 15,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child:BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      color: MyColors.blackBackGroundColor.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _menuItem(context, "Languages" ,onItemSelected),
                        _divider(),
                        _menuItem(context, "My Likes" ,onItemSelected),
                        _divider(),
                        _menuItem(context, "Contact Us" ,onItemSelected),
                        _divider(),
                        _menuItem(context, "About" ,onItemSelected),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Menu Item
  static Widget _menuItem(BuildContext context, String title, Function(String) onItemSelected) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onItemSelected(title);
        },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          title,
          style: TextStyle(
            color: MyColors.whiteColor,
            fontSize: 12.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Divider
  static Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: const Divider(color: MyColors.whiteColor, height: 0.1,thickness: 0.1,),
    );
  }
}

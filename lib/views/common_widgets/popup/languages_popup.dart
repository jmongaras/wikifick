import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/setting.dart';

class LanguagesPopup {
  static Future<void> showLanguagesMenu(BuildContext context,{required Function(String) onItemSelected}) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: 60,
              bottom: 30,
              right: 15,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child:BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.blackBackGroundColor.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          _menuItem(context, "English (ENG)", "en" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Español (ESP)", "es" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Deutsch (DEU)", "de" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Français (FRA)", "fr" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Indonesian (IDN)", "id" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Italiano (ITA)", "it" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Dutch (NLD)", "nl" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Polish (POL)", "pl" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Português (POR)", "pt" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Русский (RUS)", "ru" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "Svenska (SWE)", "sv" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "한국어 (KOR)", "ko" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "中文 (CHI)", "zh" ,onItemSelected),
                          _divider(),
                          _menuItem(context, "日本語 (JPN)", "ja" ,onItemSelected),
                        ],
                      ),
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
  static Widget _menuItem(BuildContext context, String title, String code, Function(String) onItemSelected) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onItemSelected(code);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16,bottom: 16,left: 50,right: 50),
        child: Text(
          title,
          style: TextStyle(
            color: selectedLanguage == code ? MyColors.goldenColor :  MyColors.whiteColor,
            fontSize: selectedLanguage == code ? 14.sp : 12.sp,
            fontFamily: 'Inter',
            fontWeight: selectedLanguage == code ? FontWeight.w600 : FontWeight.w400,
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

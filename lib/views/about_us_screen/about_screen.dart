import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/my_colors.dart';
import '../../utils/setting.dart';

@RoutePage()
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final prefs = await SharedPreferences.getInstance();
          dynamic internetConnection = prefs.getBool('internetConnection');
          if (internetConnection == true) {
            AutoRouter.of(context).back();
          }
          return Future.value(false);
        },
        child:_aboutUsDesign(),
    );
  }

  Widget _aboutUsDesign() {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyColors.blackColor,
        appBar: AppBar(
          backgroundColor: MyColors.blackColor,
          centerTitle: true,
          title:Text(
            "About Us",
            style: TextStyle(
              color: MyColors.whiteColor,
              fontSize: 16.sp,
              fontFamily: 'InterBold',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              AutoRouter.of(context).back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: MyColors.whiteColor,
              size: 24.sp,
            ),
          ),
        ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text(
                    aboutUs1,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    aboutUs2,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    aboutUs3,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    aboutUs4,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    aboutUs5,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

}

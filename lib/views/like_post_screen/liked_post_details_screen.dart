import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/my_colors.dart';
import '../common_widgets/db_helper/db_helper.dart';


@RoutePage()
class LikedPostDetailsScreen extends StatefulWidget {
  final String pageId;
  final String imageUrl;
  final String title;
  final String extract;
  final String postUrl;
  const LikedPostDetailsScreen(
      {super.key,
      required this.pageId,
      required this.imageUrl,
      required this.title,
      required this.extract,
      required this.postUrl});

  @override
  State<LikedPostDetailsScreen> createState() => _LikedPostDetailsScreenState();
}

class _LikedPostDetailsScreenState extends State<LikedPostDetailsScreen> {

  Future<void> removePostFromLikes(int pageId) async {
    DatabaseHelper dbHelper = DatabaseHelper.getInstance();
    await dbHelper.deleteLikedPost(pageId.toString());
    AutoRouter.of(context).back();
  }

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
      child: SafeArea(
        top: false,
        child: Scaffold(
            body: Stack(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: MyColors.blackColor,
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Bottom Shadow (Fixed)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        MyColors.blackColor,
                        MyColors.transparentColor,
                      ],
                    ),
                  ),
                ),
              ),

              //Center Description Text
              Positioned(
                  bottom: 90,
                  left: 15,
                  right: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: MyColors.blackBackGroundColor.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'InterBold',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.extract,
                                style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),

            // Top Shadow (Fixed)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MyColors.blackColor.withValues(alpha: 0.7),
                      MyColors.transparentColor,
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Shadow (Fixed)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      MyColors.blackColor,
                      MyColors.transparentColor,
                    ],
                  ),
                  // color: MyColors.blackColor
                ),
              ),
            ),

            // Bottom Read More,Share & Like Icons (Fixed)
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Uri url = Uri.parse(widget.postUrl);

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication,);
                        } else {
                          debugPrint("Not Launch Read More Url");
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: MyColors.whiteColor.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            "Read more →",
                            style: TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Share.share(widget.postUrl);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration:
                          BoxDecoration(color: MyColors.blackBackGroundColor, shape: BoxShape.circle),
                      child: Center(
                        child: Image.asset(
                          "lib/assets/icons/share_icon.png",
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      removePostFromLikes(int.parse(widget.pageId));
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration:
                          BoxDecoration(color: MyColors.blackBackGroundColor, shape: BoxShape.circle),
                      child: Center(
                          child: Lottie.asset(
                        'lib/assets/animations/like_animation.json',
                        animate: true,
                        repeat: false,
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 30,
              left: 15,
              child: GestureDetector(
                onTap: () {
                  AutoRouter.of(context).back();                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: MyColors.blackBackGroundColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: MyColors.whiteColor,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/get_all_post_data/get_all_post_data_bloc.dart';
import '../../models/wikipedia_response_model.dart';
import '../../routes/router.gr.dart';
import '../../utils/my_colors.dart';
import '../../utils/setting.dart';
import '../common_widgets/db_helper/db_helper.dart';
import '../common_widgets/loader/custom_loader.dart';
import '../common_widgets/popup/languages_popup.dart';
import '../common_widgets/popup/setting_popup.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  bool isLiked = false;
  late AnimationController rotationController;
  late GetAllPostDataBloc getAllPostDataBloc;
  bool isFetching = false;
  bool isLanguageChange = false;
  List<WikiPageModel> updatedData = [];
  String fullUrl = "";
  int currentIndex = 0;
  // String selectedLanguage = "en";

  @override
  void initState() {
    super.initState();
    getAllPostDataBloc = GetAllPostDataBloc();
    getAllPostDataBloc.add(GetAllPostData(selectedLanguage));
    pageController.addListener(onScroll);
    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: -0.2,
      upperBound: 0.2,
    );
  }

  void onScroll() {
    int newIndex = (pageController.page ?? 0).toInt();
    if (newIndex != currentIndex) {
      setState(() {
        currentIndex = newIndex;
      });
    }
    int totalItems = updatedData.length;
    if (totalItems - newIndex <= 5 &&
        !isFetching &&
        getAllPostDataBloc.state is! GetAllPostDataStateLoading) {
      isFetching = true;
      getAllPostDataBloc.add(GetAllPostData(selectedLanguage));
    }
  }

  @override
  void dispose() {
    getAllPostDataBloc.close();
    rotationController.dispose();
    super.dispose();
  }

  void fetchArticles() {
    setState(() {
      updatedData.clear();
      isLanguageChange = true;
      isFetching = true;
    });
    getAllPostDataBloc.close();
    getAllPostDataBloc = GetAllPostDataBloc();
    getAllPostDataBloc.add(GetAllPostData(selectedLanguage));
  }

  Future<void> openSettings() async {
    rotationController.forward();
    SettingPopup.showSettingMenu(
      context,
      onItemSelected: (selectedItem) async {
        switch (selectedItem) {
          case "Languages":
            LanguagesPopup.showLanguagesMenu(
              context,
              onItemSelected: (selectedLanguageCode) {
                if (selectedLanguage != selectedLanguageCode) {
                  setState(() {
                    updatedData.clear();
                    selectedLanguage = selectedLanguageCode;
                    fetchArticles();
                  });
                }
              },
            );
            break;
          case "My Likes":
            AutoRouter.of(context).push(const LikePostsScreen());
            fetchArticles();
            break;
          case "Contact Us":
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: '"test@test.com"',
            );
            if (await canLaunchUrl(emailUri)) {
              await launchUrl(emailUri, mode: LaunchMode.externalApplication,);
            } else {
              debugPrint("Could not launch email app");
            }
            break;
          case "About":
            AutoRouter.of(context).push(const AboutScreen());
            fetchArticles();
            break;
        }
      },
    ).whenComplete(() {
      rotationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllPostDataBloc,
      child: _buildGetAllPostList(context),
    );
  }

  Widget _buildGetAllPostList(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetAllPostDataBloc, GetAllPostDataState>(
          listener: (context, state) async {
            if (state is GetAllPostDataStateError) {
              isFetching = false;
              isLanguageChange = false;
              fetchArticles();
            } else if (state is GetAllPostDataStateSuccess) {
              setState(() {
                isFetching = false;
                isLanguageChange = false;
                updatedData =
                    state.wikipediaResponse.pages.where((page) => page.imageUrl.isNotEmpty).toList();
              });
              if (updatedData.isEmpty && !isFetching) {
                isFetching = true;
                getAllPostDataBloc.add(GetAllPostData(selectedLanguage));
              }
            }
          },
        ),
      ],
      child: BlocBuilder<GetAllPostDataBloc, GetAllPostDataState>(
        builder: (context, state) {
          bool isLoading = isLanguageChange ||
              state is GetAllPostDataStateInitial ||
              state is GetAllPostDataStateLoading ||
              state is GetAllPostDataStateLoaded;
          return SafeArea(
            top: false,
            child: Stack(
              children: [
                getPosts(context, updatedData),
                CustomLoader(isLoading: isLoading),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getPosts(BuildContext context, List<WikiPageModel> getAllPosts) {
    return WillPopScope(
      onWillPop: () async {
        final prefs = await SharedPreferences.getInstance();
        dynamic internetConnection = prefs.getBool('internetConnection');
        if (internetConnection == true) {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: GestureDetector(
          onVerticalDragUpdate: (details) {
            pageController.position.moveTo(
              pageController.position.pixels - details.primaryDelta!,
            );
          },
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: getAllPosts.length,
                itemBuilder: (context, index) {
                  fullUrl = getAllPosts[index].fullUrl.toString();
                  return Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: MyColors.blackColor,
                        image: DecorationImage(
                          image: NetworkImage(getAllPosts[index].imageUrl),
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
                                      getAllPosts[index].title,
                                      style: TextStyle(
                                        color: MyColors.whiteColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'InterBold',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      getAllPosts[index].extract,
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
                  ]);
                },
              ),

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

              // Top Widgets Setting Button
              Positioned(
                top: 30,
                left: 15,
                right: 15,
                child: Row(
                  children: [
                    Text(
                      "WikiFick",
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 24.sp,
                        fontFamily: 'InterBold',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: openSettings,
                      child: AnimatedBuilder(
                        animation: rotationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: rotationController.value,
                            child: child,
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: MyColors.blackBackGroundColor.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              "lib/assets/icons/setting_icon.png",
                              width: 22,
                              height: 22,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                          Uri url = Uri.parse(fullUrl);

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
                        Share.share(fullUrl);
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
                        DatabaseHelper dbHelper = DatabaseHelper.getInstance();
                        WikiPageModel post = updatedData[currentIndex];
                        bool isAlreadyLiked = await dbHelper.isPostLiked(post.pageId);
                        if (isAlreadyLiked) {
                          await dbHelper.deleteLikedPost(post.pageId);
                          setState(() {
                            post.isLiked = false;
                          });
                        } else {
                          await dbHelper.insertLikedPost(post);
                          setState(() {
                            post.isLiked = true;
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: updatedData.isNotEmpty && updatedData[currentIndex].isLiked
                                ? MyColors.blackBackGroundColor.withValues(alpha: 0.7)
                                : MyColors.blackBackGroundColor,
                            shape: BoxShape.circle),
                        child: Center(
                          child: updatedData.isNotEmpty && updatedData[currentIndex].isLiked
                              ? Lottie.asset(
                                  'lib/assets/animations/like_animation.json',
                                  animate: updatedData.isNotEmpty && updatedData[currentIndex].isLiked,
                                  repeat: false,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "lib/assets/icons/unlike_icon.png",
                                  width: 22,
                                  height: 22,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

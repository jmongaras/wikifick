import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/wikipedia_response_model.dart';
import '../../routes/router.gr.dart';
import '../../utils/my_colors.dart';
import '../common_widgets/db_helper/db_helper.dart';
import '../common_widgets/loader/custom_loader.dart';

@RoutePage()
class LikePostsScreen extends StatefulWidget {
  const LikePostsScreen({super.key});

  @override
  State<LikePostsScreen> createState() => _LikePostsScreenState();
}

class _LikePostsScreenState extends State<LikePostsScreen> {
  List<WikiPageModel> likedPosts = [];
  bool isLoading = false;
  String fullUrl = "";

  @override
  void initState() {
    super.initState();
    fetchLikedPosts();
  }

  Future<void> fetchLikedPosts() async {
    setState(() {
      isLoading = true;
    });
    DatabaseHelper dbHelper = DatabaseHelper.getInstance();
    List<WikiPageModel> posts = await dbHelper.getLikedPosts();
    setState(() {
      likedPosts = posts;
      isLoading = false;
    });
  }

  Future<void> removePostFromLikes(int pageId) async {
    setState(() {
      isLoading = true;
    });
    DatabaseHelper dbHelper = DatabaseHelper.getInstance();
    await dbHelper.deleteLikedPost(pageId.toString());
    fetchLikedPosts();
  }

  Future<void> openDetailsScreen(String pageId, String imageUrl, String title, String extract, String postUrl) async {
    await AutoRouter.of(context).push(LikedPostDetailsScreen(
        pageId: pageId,
        imageUrl: imageUrl,
        postUrl: fullUrl,
        title: title,
        extract: extract));

    await fetchLikedPosts();
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
          child: Stack(
            children: [
              _likedPostsDesign(),
              CustomLoader(isLoading: isLoading),
            ],
          ),
        ));
  }

  Widget _likedPostsDesign() {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      appBar: AppBar(
        backgroundColor: MyColors.blackColor,
        centerTitle: true,
        title: Text(
          "Likes",
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
      body: likedPosts.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: likedPosts.length,
                itemBuilder: (context, index) {
                  fullUrl = likedPosts[index].fullUrl.toString();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        openDetailsScreen(likedPosts[index].pageId, likedPosts[index].imageUrl, likedPosts[index].title,  likedPosts[index].extract, likedPosts[index].fullUrl);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.blackBackGroundColor, borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(likedPosts[index].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width:8),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      likedPosts[index].title,
                                      style: TextStyle(
                                        color: MyColors.whiteColor,
                                        fontSize: 12.sp,
                                        fontFamily: 'InterBold',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      likedPosts[index].extract,
                                      style: TextStyle(
                                        color: MyColors.whiteColor,
                                        fontSize: 12.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                             Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  removePostFromLikes(int.parse(likedPosts[index].pageId));
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration:
                                      BoxDecoration(color: MyColors.whiteColor, shape: BoxShape.circle),
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
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text(
                "No Post Find",
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 24.sp,
                  fontFamily: 'InterBold',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }
}

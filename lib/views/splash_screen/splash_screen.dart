import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/internet_connect/internet_connect_bloc.dart';
import '../../routes/router.gr.dart';
import '../../utils/my_colors.dart';
import '../common_widgets/popup/internet_connection_popup.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      AutoRouter.of(context).push(const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final prefs = await SharedPreferences.getInstance();
        dynamic internetConnection = prefs.getBool('internetConnection');
        if (internetConnection == true) {
          SystemChannels.platform
              .invokeMethod<void>('SystemNavigator.pop');
        }
        return Future.value(false);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetConnectBloc>(
            create: (BuildContext context) => InternetConnectBloc(),
          ),
        ],
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: MyColors.blackColor,
            body: _buildSplashScreen(),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashScreen() {
    return MultiBlocListener(listeners: [
      BlocListener<InternetConnectBloc, InternetConnectState>(
        listener: (context, state) async {
          if (state is InternetConnectedFailure) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("internetConnection", false);
            ShowInterNetToastDialog.showNotInternetMsg();
          } else if (state is InternetConnectedSucess) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("internetConnection", true);
            ShowInterNetToastDialog.closeLoader();
          }
        },
      ),
    ], child: splashScreenLoading(context));
  }



  Widget splashScreenLoading(BuildContext context) {
    return Center(
      child:Text(
        "WikiFick",
        style: TextStyle(
          color: MyColors.whiteColor,
          fontSize: 40.sp,
          fontFamily: 'InterBold',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

}

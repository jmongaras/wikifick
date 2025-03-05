import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wikifick/routes/router.dart';
import 'package:wikifick/utils/my_colors.dart';
import 'package:wikifick/views/common_widgets/common_functions/comman_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:MyColors.blackColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.blackColor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: MyColors.blackColor,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: MaterialApp.router(
          title: 'WikiFick',
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          theme: ThemeData(
            fontFamily: 'Inter',
            canvasColor:MyColors.whiteColor,
            colorScheme: ColorScheme.fromSeed(seedColor: MyColors.blackColor),
            useMaterial3: true,
            scaffoldBackgroundColor: MyColors.whiteColor,
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: SlidePageTransitionsBuilder(),
                TargetPlatform.iOS: SlidePageTransitionsBuilder(),
              },
            ),
          ),
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}


class SlidePageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}

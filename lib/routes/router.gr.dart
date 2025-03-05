// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:wikifick/views/about_us_screen/about_screen.dart' as _i1;
import 'package:wikifick/views/home_screen/home_screen.dart' as _i2;
import 'package:wikifick/views/like_post_screen/like_posts_screen.dart' as _i3;
import 'package:wikifick/views/like_post_screen/liked_post_details_screen.dart'
    as _i4;
import 'package:wikifick/views/splash_screen/splash_screen.dart' as _i5;

/// generated route for
/// [_i1.AboutScreen]
class AboutScreen extends _i6.PageRouteInfo<void> {
  const AboutScreen({List<_i6.PageRouteInfo>? children})
    : super(AboutScreen.name, initialChildren: children);

  static const String name = 'AboutScreen';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreen extends _i6.PageRouteInfo<void> {
  const HomeScreen({List<_i6.PageRouteInfo>? children})
    : super(HomeScreen.name, initialChildren: children);

  static const String name = 'HomeScreen';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LikePostsScreen]
class LikePostsScreen extends _i6.PageRouteInfo<void> {
  const LikePostsScreen({List<_i6.PageRouteInfo>? children})
    : super(LikePostsScreen.name, initialChildren: children);

  static const String name = 'LikePostsScreen';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.LikePostsScreen();
    },
  );
}

/// generated route for
/// [_i4.LikedPostDetailsScreen]
class LikedPostDetailsScreen
    extends _i6.PageRouteInfo<LikedPostDetailsScreenArgs> {
  LikedPostDetailsScreen({
    _i7.Key? key,
    required String pageId,
    required String imageUrl,
    required String title,
    required String extract,
    required String postUrl,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         LikedPostDetailsScreen.name,
         args: LikedPostDetailsScreenArgs(
           key: key,
           pageId: pageId,
           imageUrl: imageUrl,
           title: title,
           extract: extract,
           postUrl: postUrl,
         ),
         initialChildren: children,
       );

  static const String name = 'LikedPostDetailsScreen';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LikedPostDetailsScreenArgs>();
      return _i4.LikedPostDetailsScreen(
        key: args.key,
        pageId: args.pageId,
        imageUrl: args.imageUrl,
        title: args.title,
        extract: args.extract,
        postUrl: args.postUrl,
      );
    },
  );
}

class LikedPostDetailsScreenArgs {
  const LikedPostDetailsScreenArgs({
    this.key,
    required this.pageId,
    required this.imageUrl,
    required this.title,
    required this.extract,
    required this.postUrl,
  });

  final _i7.Key? key;

  final String pageId;

  final String imageUrl;

  final String title;

  final String extract;

  final String postUrl;

  @override
  String toString() {
    return 'LikedPostDetailsScreenArgs{key: $key, pageId: $pageId, imageUrl: $imageUrl, title: $title, extract: $extract, postUrl: $postUrl}';
  }
}

/// generated route for
/// [_i5.SplashScreen]
class SplashScreen extends _i6.PageRouteInfo<void> {
  const SplashScreen({List<_i6.PageRouteInfo>? children})
    : super(SplashScreen.name, initialChildren: children);

  static const String name = 'SplashScreen';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashScreen();
    },
  );
}

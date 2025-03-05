import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/my_colors.dart';

class CustomLoader extends StatelessWidget {
  final bool isLoading;

  const CustomLoader({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return SizedBox.shrink();

    return Stack(
      children: [
        Positioned.fill(
          child: ModalBarrier(
            color: MyColors.blackColor,
            dismissible: false,
          ),
        ),
        // Loader UI
        Positioned.fill(
          child: Center(
            child: SpinKitWave(
              color: MyColors.whiteColor,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/presentation/journey/main/main_controller.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubscribeButton extends StatelessWidget {
  final bool isPremiumFull;
  const SubscribeButton({super.key, required this.isPremiumFull});

  @override
  Widget build(BuildContext context) {
    if (isPremiumFull) {
      return const SizedBox.shrink();
    } else {
      return AppTouchable(
          onPressed: () {
            Get.find<MainController>().pushToSubscribeScreen();
          },
          child: Image.asset(
            AppImage.iosPremium,
            height: 36.0.sp,
          ));
    }
  }

}
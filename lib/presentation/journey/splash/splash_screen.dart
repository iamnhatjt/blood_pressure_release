import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      isShowBanner: false,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImageWidget.asset(
                  path: AppImage.logo,
                  width: Get.width / 3 * 2,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 12.0.sp),
                Text(
                  'Blood Pressure',
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 12.0.sp),
                const CircularProgressIndicator(
                    color: AppColor.secondaryColor),
              ],
            ),
            Positioned(
              bottom: 20.0.sp,
              child: Obx(() => Text(
                    controller.version.value,
                    style: const TextStyle(
                      color: AppColor.black,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_image_widget.dart';

class IosLeftHeaderWidget extends StatelessWidget {
  final bool isShow;
  final bool isHome;

  const IosLeftHeaderWidget({Key? key, this.isShow = true, this.isHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isShow
        ? const SizedBox.shrink()
        : isHome? AppImageWidget.asset(path: AppImage.iosSetting, height: 32.0.sp,) : AppImageWidget.asset(path: AppImage.iosBack, height: 40.0.sp,) ;
  }
}

class IosRightHeaderWidget extends StatelessWidget {
  final bool isShow;

  const IosRightHeaderWidget({Key? key, this.isShow = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isShow
        ? SizedBox.shrink()
        : Get.find<AppController>().isPremiumFull.value
            ? const SizedBox.shrink()
            : AppImageWidget.asset(path: AppImage.ic_premium);
  }
}

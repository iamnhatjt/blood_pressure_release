import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodNativeAdsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTouchable.common(
          onPressed: null,
          height: 132.sp,
          width: Get.width,
          child: const Text("NativeAd"),
        ),
        SizedBox(
          height: 20.sp,
        ),
      ],
    );
  }

}
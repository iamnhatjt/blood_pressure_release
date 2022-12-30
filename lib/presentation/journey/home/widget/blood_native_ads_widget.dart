import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/presentation/widget/native_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodNativeAdsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NativeAdsWidget(
          height: 100.sp,
          width: Get.width,
          isPremium: false,
          factoryId:
              NativeFactoryId.appNativeAdFactorySmall,
        ),
        SizedBox(
          height: 20.sp,
        ),
      ],
    );
  }
}

import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/app_touchable.dart';
import 'blood_native_ads_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String imagePath;
  final double imageWidth;
  final String message;
  final bool isPremium;

  const EmptyWidget(
      {Key? key,
      required this.imagePath,
      required this.message,
      required this.imageWidth,
      required this.isPremium})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              AppImageWidget.asset(
                path: imagePath,
                width: imageWidth,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 52.sp),
                child: Text(
                  message,
                  style:  IosTextStyle.StyleBodyChartEmptyData.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
        // BloodNativeAdsWidget(isPremium: isPremium,),
      ],
    );
  }
}

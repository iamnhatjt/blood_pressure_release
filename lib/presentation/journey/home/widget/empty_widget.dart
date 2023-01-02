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

  const EmptyWidget(
      {Key? key,
      required this.imagePath,
      required this.message,
      required this.imageWidth})
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
                  style: textStyle20700().copyWith(color: AppColor.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
        BloodNativeAdsWidget(),
      ],
    );
  }
}

import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/container_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SystolicDiastolicWidget extends StatelessWidget {
  final int systolicMin;
  final int systolicMax;
  final int diastolicMin;
  final int diastolicMax;
  const SystolicDiastolicWidget(
      {Key? key,
      required this.systolicMin,
      required this.systolicMax,
      required this.diastolicMin,
      required this.diastolicMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonIos3D(
      innerColor: const Color(0xFF89C7FF).withOpacity(0.5),
      radius: 16,
      offsetInner: const Offset(0, 0),

      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 10.sp, horizontal: 20.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ItemWidget(
                title: TranslationConstants.systolic.tr,
                min: systolicMin,
                max: systolicMax),
            _ItemWidget(
                title: TranslationConstants.diastolic.tr,
                min: diastolicMin,
                max: diastolicMax),
          ],
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final String title;
  final int min;
  final int max;
  const _ItemWidget(
      {Key? key,
      required this.title,
      required this.min,
      required this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            title,
            style: textStyle18400()
                .copyWith(color: const Color(0xFF646464)),
          ),
        ),
        SizedBox(
          height: 4.sp,
        ),
        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    TranslationConstants.min.tr,
                    style: textStyle14400()
                        .copyWith(color: const Color(0xFF646464)),
                  ),
                ),
                Text(
                  '$min',
                  style: textStyle24700()
                      .copyWith(color:const Color(0xFF646464)),
                )
              ],
            ),
            SizedBox(
              width: 10.sp,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    TranslationConstants.max.tr,
                    style: textStyle14400()
                        .copyWith(color: const Color(0xFF646464)),
                  ),
                ),
                Text(
                  '$max',
                  style: textStyle24700()
                      .copyWith(color: const Color(0xFF646464)),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}

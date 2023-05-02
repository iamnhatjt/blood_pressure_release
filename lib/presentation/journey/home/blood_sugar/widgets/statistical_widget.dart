import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/container_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodSugarStatisticalWidget extends StatelessWidget {
  final double average;
  final double min;
  final double max;

  const BloodSugarStatisticalWidget(
      {super.key,
      required this.average,
      required this.min,
      required this.max});

  Widget _buildItemWidget({required String title, required double value}) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: textStyle18400().copyWith(color: const Color(0xFF646464))),
          Text(
            '$value',
            style: textStyle22700().copyWith(color: const Color(0xFF646464)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonIos3D.onlyInner(
      innerColor: const Color(0xFF89C7FF).withOpacity(0.5),
      radius: 16,
      offsetInner: const Offset(0, 0),
      child: Padding(

        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),

        child: Row(
          children: [
            _buildItemWidget(
                title: TranslationConstants.average.tr, value: average),
            _buildItemWidget(title: TranslationConstants.min.tr, value: min),
            _buildItemWidget(title: TranslationConstants.max.tr, value: max),
          ],
        ),
      ),
    );
  }
}

import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodSugarStatisticalWidget extends StatelessWidget {
  final RxDouble rxAverage;
  final RxDouble rxMin;
  final RxDouble rxMax;

  const BloodSugarStatisticalWidget(
      {super.key,
      required this.rxAverage,
      required this.rxMin,
      required this.rxMax});

  Widget _buildItemWidget({required String title, required RxDouble value}) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: textStyle18400()),
          Obx(
            () => Text(
              '${value.value}',
              style: textStyle22700(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      child: Row(
        children: [
          _buildItemWidget(
              title: TranslationConstants.average.tr, value: rxAverage),
          _buildItemWidget(title: TranslationConstants.min.tr, value: rxMin),
          _buildItemWidget(title: TranslationConstants.max.tr, value: rxMax),
        ],
      ),
    );
  }
}

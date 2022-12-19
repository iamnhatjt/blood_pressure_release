import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/app_color.dart';

class ChartBottomTitleWidget extends StatelessWidget {
  final DateTime minDate;
  final DateTime maxDate;
  final List<Map> listChartData;
  final double value;
  final TitleMeta meta;
  const ChartBottomTitleWidget(
      {Key? key,
      required this.minDate,
      required this.maxDate,
      required this.listChartData,
      required this.value,
      required this.meta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final title = DateFormat('dd/MM/yy',
            appController.currentLocale.languageCode)
        .format(dateTime);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10.0.sp,
      child: Text(
        title,
        style: textStyle12500()
            .copyWith(color: AppColor.black),
      ),
    );
  }
}

import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/app_color.dart';

class ChartBottomTitleWidget extends StatelessWidget {
  final int selected;
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
      required this.meta, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('value chart bar: $value $selected}');
    final appController = Get.find<AppController>();
    int compareValueTime = selected ==0? listChartData[0]['dateTime'] : selected;
    bool checkingSelected = compareValueTime == value;
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final title = DateFormat('dd - MM',
            appController.currentLocale.languageCode)
        .format(dateTime);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0.0.sp,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: checkingSelected ? Color(0xFF40A4FF) : Colors.transparent,

        ),

        padding:  EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.0.sp),
        child: Text(
          title,
          style: checkingSelected ? textStyle12500()
              .copyWith(color: Colors.white) :  textStyle12500()
              .copyWith(color: const Color(0xFF6F6F6F)),
        ),
      ),
    );
  }
}

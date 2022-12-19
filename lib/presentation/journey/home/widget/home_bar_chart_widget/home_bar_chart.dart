import 'package:bloodpressure/presentation/journey/home/widget/home_bar_chart_widget/chart_title_widget/chart_left_title_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/util/disable_ glow_behavior.dart';
import 'chart_title_widget/chart_bottom_title_widget.dart';

class HomeBarChart extends StatelessWidget {
  final DateTime maxDate;
  final DateTime minDate;

  ///
  /// {
  ///   "fromY": 10,
  ///   "toY": 12,
  ///   "date": milisecond
  /// }
  ///
  final List<Map> listChartData;
  final Function(int) onSelectChartItem;
  final int currentSelected;
  const HomeBarChart({
    Key? key,
    required this.maxDate,
    required this.minDate,
    required this.listChartData,
    required this.onSelectChartItem,
    required this.currentSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.0.sp),
        scrollDirection: Axis.horizontal,
        child: Container(
          width: (maxDate.difference(minDate).inDays + 2) *
              40.0.sp,
          constraints:
              BoxConstraints(minWidth: Get.width / 7 * 6),
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: AppColor.gray2,
                  strokeWidth: 1.sp,
                ),
              ),
              alignment: BarChartAlignment.spaceAround,
              borderData: FlBorderData(
                show: false,
              ),
              barTouchData: barTouchData,
              titlesData: titlesData,
              barGroups: barGroups,
            ),
            swapAnimationDuration:
                const Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30.sp,
            getTitlesWidget: (value, meta) =>
                ChartBottomTitleWidget(
              minDate: minDate,
              maxDate: maxDate,
              listChartData: listChartData,
              value: value,
              meta: meta,
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: (value, meta) =>
                ChartLeftTitleWidget(value: value),
            showTitles: true,
            interval: 1,
            reservedSize: 16.0.sp,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchCallback: (event, response) =>
            onSelectChartItem(
                response?.spot?.spot.x.toInt() ?? 0),
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8.sp,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  List<BarChartGroupData> get barGroups => listChartData
      .map(
        (e) =>
            BarChartGroupData(x: e['dateTime'], barRods: [
          BarChartRodData(
            toY: (e['toY'] as int).toDouble(),
            fromY: (e['fromY'] as int).toDouble(),
            color: currentSelected == e['dateTime']
                ? AppColor.yellow
                : AppColor.green,
          )
        ]),
      )
      .toList();
}

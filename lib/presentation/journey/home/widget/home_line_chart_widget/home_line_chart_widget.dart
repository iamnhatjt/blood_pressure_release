import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/util/app_util.dart';
import '../../../../../common/util/disable_glow_behavior.dart';

class HomeLineChartWidget extends StatelessWidget {
  final List<Map>? listChartData;
  final DateTime? minDate;
  final DateTime? maxDate;
  final int selectedX;
  final int spotIndex;
  final double maxY;
  final double minY;
  final Widget Function(double value, TitleMeta meta)?
      buildLeftTitle;
  final FlDotPainter Function(
    FlSpot spotValue,
    double doubleValue,
    LineChartBarData lineChartBarDataValue,
    int intValue,
  )? buildDot;
  final double? horizontalInterval;
  final Function(int x, int spotIndex, DateTime dateTime)?
      onPressDot;
  final List<LineTooltipItem?> Function(List<LineBarSpot>)?
      getTooltipItems;

  const HomeLineChartWidget({
    Key? key,
    required this.listChartData,
    required this.minDate,
    required this.maxDate,
    required this.selectedX,
    this.onPressDot,
    this.buildLeftTitle,
    this.buildDot,
    required this.maxY,
    required this.minY,
    this.horizontalInterval,
    required this.spotIndex,
    this.getTooltipItems,
  }) : super(key: key);

  LineChartBarData get _generateLineChartBarData {
    List<FlSpot> listFlSpot = [];
    for (final item in listChartData!) {
      listFlSpot.add(FlSpot(
          (minDate!
                      .difference(item['date']!)
                      .inDays
                      .toDouble())
                  .abs() +
              1,
          item['value'].toDouble()));
    }
    listFlSpot.sort((a, b) => a.x.compareTo(b.x));
    return LineChartBarData(
      isCurved: true,
      color:const Color(0xFF92B6CA),
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(
          show: true,
          getDotPainter: buildDot ?? _getDotPainter),
      belowBarData: BarAreaData(show: false),
      spots: listFlSpot,
    );
  }

  FlDotPainter _getDotPainter(
    FlSpot spotValue,
    double doubleValue,
    LineChartBarData lineChartBarDataValue,
    int intValue,
  ) {
    Color color = AppColor.primaryColor;
    if (spotValue.y < 60) {
      color = AppColor.violet;
    } else if (spotValue.y > 100) {
      color = AppColor.red;
    } else {
      color = AppColor.green;
    }
    color = const Color(0xFF40A4FF);
    return FlDotCirclePainter(
      radius: 7.0.sp,
      color: (selectedX ?? 0) == 0 &&
              spotValue.x ==
                  lineChartBarDataValue.spots.last.x
          ? color
          : selectedX == spotValue.x
              ? color
              : color,
      strokeColor: Colors.transparent,
      strokeWidth: 1,
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: const Color(0xFF6F6F6F),

      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
    );

    TextStyle styleHover = TextStyle(
      color: Colors.white,

      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
    );


    int checkNumber = selectedX == 0 ? 1 : selectedX;
    print('selectx $selectedX, value $value, length: ${listChartData!.length}');

    Widget text = const SizedBox.shrink();
    DateTime dateTime = DateTime(
        minDate!.year, minDate!.month, minDate!.day);
    while (!dateTime.isAfter(maxDate!)) {
      if (dateTime.difference(minDate!).inDays + 1 ==
          value.toInt()) {
        for (final item in listChartData!) {
          if (dateTime.isAtSameMomentAs(item['date'])) {
            text = Text(
                DateFormat('dd - MM').format(dateTime),
                style:  checkNumber == value ? styleHover:  style);
            break;
          }
        }
        break;
      }
      dateTime = dateTime.add(const Duration(days: 1));
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0.sp,
      child: Container(
          padding: checkNumber == value ? EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.0.sp) : EdgeInsets.symmetric(vertical: 4.0.sp),
          decoration: BoxDecoration(
            color: checkNumber == value ?const Color(0xFF40A4FF) : const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6)
          ),
          child: text),
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: const Color(0xFF6E6E6E),
      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
    );
    String text;
    switch (value.toInt()) {
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;
      case 250:
        text = '250';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(

      padding:  EdgeInsets.symmetric(vertical: 5.0.sp, horizontal: 8.0.sp),
      child: Text(text,
          style: style, textAlign: TextAlign.center),
    );
  }

  SideTitles _leftTitles() => SideTitles(
        getTitlesWidget:
            buildLeftTitle ?? _leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40.0.sp,
      );

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: _bottomTitleWidgets,
      );

  LineTouchData get _lineTouchData1 => LineTouchData(
      enabled: false,
      handleBuiltInTouches: false,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.black,
        tooltipRoundedRadius: 8,
        getTooltipItems:
            getTooltipItems ?? _getTooltipItems,
      ),
      touchCallback: (flTouchEvent, touchResponse) {
        if ((touchResponse?.lineBarSpots ?? [])
            .isNotEmpty) {
          final value = touchResponse?.lineBarSpots![0].x;
          final spotIndex =
              touchResponse?.lineBarSpots!.first.spotIndex;
          DateTime dateTime = minDate!.add(
              Duration(days: (value ?? 1).toInt() - 1));
          if (onPressDot != null) {
            onPressDot!(
                value!.toInt(), spotIndex!, dateTime);
          }
        }
      },
      getTouchedSpotIndicator:
          (LineChartBarData barData, List<int> indicators) {
        return indicators.map((int index) {
          var lineColor = barData.gradient?.colors.first ??
              barData.color;
          if (barData.dotData.show) {
            lineColor = Colors.transparent;
          }
          const lineStrokeWidth = 4.0;
          final flLine = FlLine(
              color: lineColor,
              strokeWidth: lineStrokeWidth);
          final dotData = FlDotData(
              getDotPainter: (spot, percent, bar, index) =>
                  FlDotCirclePainter(
                    radius: 7.0.sp,
                    color: Colors.transparent,
                    strokeColor: Colors.transparent,
                  ));

          return TouchedSpotIndicatorData(flLine, dotData);
        }).toList();
      });
  List<LineTooltipItem?> _getTooltipItems(
      List<LineBarSpot> lineBarSpots) {
    log('lineBarsSpot length: ${lineBarSpots.length}');
    return lineBarSpots.map((lineBarSpot) {
      log('lineBarSpot ${lineBarSpot.spotIndex}');
      return LineTooltipItem(
        lineBarSpot.y.toString(),
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }

  FlGridData get _gridData => FlGridData(


        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: horizontalInterval ?? 5,
        getDrawingHorizontalLine: (value) => FlLine(
          color:const Color(0xFFCDD6E9),
          strokeWidth: 1.sp,
        ),
      );

  FlTitlesData get _titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: _bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: _leftTitles(),
        ),
      );

  FlBorderData get _borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  List<LineChartBarData> get _lineBarsData1 =>
      [_generateLineChartBarData];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.0.sp),
        scrollDirection: Axis.horizontal,
        child: Container(
          width:

              (maxDate!.difference(minDate!).inDays + 2) *
                  40.0.sp,
          constraints:
              BoxConstraints(minWidth: Get.width / 7 * 6),
          child: LineChart(
            LineChartData(

              backgroundColor: Colors.transparent,
              lineTouchData: _lineTouchData1,
              gridData: _gridData,
              titlesData: _titlesData1,
              borderData: _borderData,
              lineBarsData: _lineBarsData1,
              showingTooltipIndicators: [
                ShowingTooltipIndicators([
                  LineBarSpot(
                      _generateLineChartBarData,
                      0,
                      _generateLineChartBarData
                          .spots[spotIndex])
                ])
              ],
              minX: 0,
              maxX:
                  maxDate!.difference(minDate!).inDays + 2,
              maxY: maxY,
              minY: minY,
            ),
            swapAnimationDuration:
                const Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/util/app_util.dart';
import '../../../../../common/util/disable_glow_behavior.dart';
import '../../../../theme/app_color.dart';

class HomeLineChartWidget extends StatefulWidget {
  final List<Map>? listChartData;
  final DateTime? minDate;
  final DateTime? maxDate;
  final int selectedX;
  final int spotIndex;
  final double maxY;
  final double minY;
  final Widget Function(double value, TitleMeta meta)? buildLeftTitle;
  final FlDotPainter Function(
      FlSpot spotValue,
      double doubleValue,
      LineChartBarData lineChartBarDataValue,
      int intValue,
      )? buildDot;
  final double? horizontalInterval;
  final Function(int x, int spotIndex, DateTime dateTime)? onPressDot;
  final List<LineTooltipItem?> Function(List<LineBarSpot>)? getTooltipItems;

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

  @override
  State<HomeLineChartWidget> createState() => _HomeLineChartWidgetState();
}

class _HomeLineChartWidgetState extends State<HomeLineChartWidget> {
  String _datePicker = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 200), () {
      setState(() {
        _datePicker = DateFormat('dd/MM')
            .format(widget.listChartData?.last['date'] ?? DateTime.now());
      });
    });
  }

  LineChartBarData get _generateLineChartBarData {
    List<FlSpot> listFlSpot = [];
    for (final item in widget.listChartData!) {
      listFlSpot.add(FlSpot(
          (widget.minDate!.difference(item['date']!).inDays.toDouble()).abs() +
              1,
          item['value'].toDouble()));
    }
    listFlSpot.sort((a, b) => a.x.compareTo(b.x));
    return LineChartBarData(
      isCurved: true,
      color: Colors.transparent,
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(
          show: true, getDotPainter: widget.buildDot ?? _getDotPainter),
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
    Color color = AppColor.black;
    if (spotValue.y < 60) {
      color = AppColor.violet;
    } else if (spotValue.y > 100) {
      color = AppColor.red;
    } else {
      color = AppColor.green;
    }
    return FlDotCirclePainter(
      radius: 7.0.sp,
      color: (widget.selectedX ?? 0) == 0 &&
          spotValue.x == lineChartBarDataValue.spots.last.x
          ? const Color(0xFF40A4FF)
          : widget.selectedX == spotValue.x
          ? const Color(0xFF40A4FF)
          : const Color(0xFF40A4FF),
      // strokeColor: Colors.transparent,
      // strokeWidth: 1,
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: const Color(0xFF6F6F6F),
      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
    );
    String _dateTime = '';

    Widget text = const SizedBox.shrink();
    DateTime dateTime = DateTime(
        widget.minDate!.year, widget.minDate!.month, widget.minDate!.day);
    while (!dateTime.isAfter(widget.maxDate!)) {
      if (dateTime.difference(widget.minDate!).inDays + 1 == value.toInt()) {
        for (final item in widget.listChartData!) {
          if (dateTime.isAtSameMomentAs(item['date'])) {
            _dateTime = DateFormat('dd/MM').format(dateTime);
            text = Text(DateFormat('dd/MM').format(dateTime), style: style);
            break;
          }
        }
        break;
      }
      dateTime = dateTime.add(const Duration(days: 1));
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      // space: 10.0.sp,
      child: _datePicker == _dateTime && _dateTime != ''
          ? Container(
        padding:
        EdgeInsets.symmetric(vertical: 3.0.sp, horizontal: 6.0.sp),
        decoration: BoxDecoration(
          color: const Color(0xFF40A4FF),
          borderRadius: BorderRadius.circular(6.0.sp),
        ),
        child: Text(
          _dateTime.replaceAll('/', ' - '),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      )
          : Padding(
        padding:
        EdgeInsets.symmetric(vertical: 3.0.sp, horizontal: 6.0.sp),
        child: Text(_dateTime.replaceAll('/', ' - '),
            style: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6F6F6F),
            )),
      ),
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
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles _leftTitles() => SideTitles(
    getTitlesWidget: widget.buildLeftTitle ?? _leftTitleWidgets,
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
        tooltipBgColor: Colors.transparent,
        tooltipRoundedRadius: 8,
        getTooltipItems: widget.getTooltipItems ?? _getTooltipItems,
      ),
      touchCallback: (flTouchEvent, touchResponse) {
        if ((touchResponse?.lineBarSpots ?? []).isNotEmpty) {
          final value = touchResponse?.lineBarSpots![0].x;
          final spotIndex = touchResponse?.lineBarSpots!.first.spotIndex;
          DateTime dateTime =
          widget.minDate!.add(Duration(days: (value ?? 1).toInt() - 1));
          if (widget.onPressDot != null) {
            widget.onPressDot!(value!.toInt(), spotIndex!, dateTime);
            setState(() {
              _datePicker = DateFormat('dd/MM').format(dateTime);
            });
          }
        }
      },
      getTouchedSpotIndicator:
          (LineChartBarData barData, List<int> indicators) {
        return indicators.map((int index) {
          var lineColor = barData.gradient?.colors.first ?? barData.color;
          if (barData.dotData.show) {
            lineColor = Colors.transparent;
          }
          const lineStrokeWidth = 4.0;
          final flLine = FlLine(color: lineColor, strokeWidth: lineStrokeWidth);
          final dotData = FlDotData(
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: 7.0.sp,
                color: const Color(0xFF40A4FF),
                strokeColor: const Color(0xFF40A4FF),
              ));

          return TouchedSpotIndicatorData(flLine, dotData);
        }).toList();
      });

  List<LineTooltipItem?> _getTooltipItems(List<LineBarSpot> lineBarSpots) {
    log('lineBarsSpot length: ${lineBarSpots.length}');
    return lineBarSpots.map((lineBarSpot) {
      log('lineBarSpot ${lineBarSpot.spotIndex}');
      return LineTooltipItem(
        lineBarSpot.y.toString(),
        const TextStyle(
          color: Colors.transparent,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }

  FlGridData get _gridData => FlGridData(
    drawHorizontalLine: true,
    drawVerticalLine: false,
    horizontalInterval: widget.horizontalInterval ?? 5,
    getDrawingHorizontalLine: (value) => FlLine(
      color: const Color(0xFFCDD6E9),
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

  List<LineChartBarData> get _lineBarsData1 => [_generateLineChartBarData];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: SingleChildScrollView(

        padding: EdgeInsets.only(top: 6.0.sp),
        scrollDirection: Axis.horizontal,
        child: Container(
          width: (widget.maxDate!.difference(widget.minDate!).inDays + 2) *
              40.0.sp,
          constraints: BoxConstraints(minWidth: Get.width / 7 * 6),
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
                  LineBarSpot(_generateLineChartBarData, 0,
                      _generateLineChartBarData.spots[widget.spotIndex])
                ])
              ],
              minX: 0,
              maxX: widget.maxDate!.difference(widget.minDate!).inDays + 2,
              maxY: widget.maxY,
              minY: widget.minY,
            ),
            swapAnimationDuration: const Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }
}


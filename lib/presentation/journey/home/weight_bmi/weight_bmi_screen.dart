import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/domain/enum/bmi_type.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/weight_bmi_controller.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/widget/bmi_detail_widget.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/widget/line_chart_title_widget.dart';
import 'package:bloodpressure/presentation/journey/home/widget/alarm_add_data_button.dart';
import 'package:bloodpressure/presentation/journey/home/widget/empty_widget.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_header.dart';
import '../../../widget/filter/filter_date_widget.dart';
import '../../../widget/ios_cofig_widget/picker_time_and_export.dart';
import '../../../widget/ios_cofig_widget/widget_buton_handle_data.dart';

class WeightBMIScreen extends GetView<WeightBMIController> {
  const WeightBMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final appController = Get.find<AppController>();
    return AppContainer(
      isShowBanner: false,
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.weightAndBMI.tr,
            titleStyle: IosTextStyle.StyleHeaderApp,
            leftWidget: const IosLeftHeaderWidget(),
            rightWidget: const IosRightHeaderWidget(),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
              child: Column(
                children: [
                  Obx(() => PickTimeAndExport(
                      isChart: controller.bmiList.isNotEmpty,
                      pickerTimeClick: () {
                        controller.onPressDateRange(context);
                      },
                      textTime: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0.sp, horizontal: 22.0.sp),
                        child: Text(
                          '${DateFormat('MMM dd, yyyy').format(controller.filterStartDate.value)} - ${DateFormat('MMM dd, yyyy').format(controller.filterEndDate.value)}',
                          style: IosTextStyle.IosTextPickTime,
                        ),
                      ),
                      exportClick: controller.exportData)),
                  Obx(
                    () {
                      if (controller.bmiList.isNotEmpty) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 4.0.sp),
                          color: const Color(0XFFF4FAFF),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonIos3D(
                                  height: 36.0.sp,
                                  width: 152.0.sp,
                                  innerColor: controller.isWeight.value
                                      ? const Color(0xFF000000)
                                          .withOpacity(0.15)
                                      : Color(0xFF000000).withOpacity(0.15),
                                  dropColor: controller.isWeight.value
                                      ? Colors.transparent
                                      : Colors.black.withOpacity(0.25),
                                  offsetInner: controller.isWeight.value
                                      ? Offset(0, -4)
                                      : Offset(0, -2),
                                  offsetDrop: Offset(0, 1),
                                  onPress: controller.ChangeToWeight,
                                  radius: 10,
                                  backgroundColor: controller.isWeight.value
                                      ? const Color(0xFF5298EB)
                                      : Colors.white,
                                  child: Center(
                                    child: Text(
                                      TranslationConstants.weight.tr,
                                      style: IosTextStyle.f18w700w.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: controller.isWeight.value
                                            ? Colors.white
                                            : const Color(0xFF656565),
                                      ),
                                    ),
                                  )),
                              SizedBox(width: 20.0.sp),
                              ButtonIos3D(
                                  height: 36.0.sp,
                                  width: 152.0.sp,
                                  innerColor: !controller.isWeight.value
                                      ? const Color(0xFF000000)
                                          .withOpacity(0.15)
                                      : Color(0xFF000000).withOpacity(0.15),
                                  dropColor: !controller.isWeight.value
                                      ? Colors.transparent
                                      : Colors.black.withOpacity(0.25),
                                  offsetInner: !controller.isWeight.value
                                      ? Offset(0, -4)
                                      : Offset(0, -2),
                                  offsetDrop: Offset(0, 1),
                                  onPress: controller.ChangeToBMI,
                                  radius: 10,
                                  backgroundColor: !controller.isWeight.value
                                      ? const Color(0xFF5298EB)
                                      : Colors.white,
                                  child: Center(
                                    child: Text(
                                      TranslationConstants.bmi.tr,
                                      style: IosTextStyle.f18w700w.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: !controller.isWeight.value
                                            ? Colors.white
                                            : const Color(0xFF656565),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  Expanded(child: Obx(() {
                    if (controller.bmiList.isNotEmpty) {
                      return SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(16.0.sp)),
                            color: const Color(0XFFF4FAFF),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.sp)
                              .copyWith(top: 16.sp),
                          child: Column(
                            children: [
                              SizedBox(height: 24.0.sp),

                              controller.isWeight.value
                                  ? LineChartTitleWidget(
                                      title:
                                          '${TranslationConstants.weight.tr} (${controller.weightUnit.value.name})',
                                      minDate: controller.chartMinDate.value,
                                      maxDate: controller.chartMaxDate.value,
                                      listChartData:
                                          controller.weightChartListData,
                                      buildLeftTitle:
                                          _buildLeftTitleWeightChart,
                                      horizontalInterval: 50,
                                      selectedX:
                                          controller.chartSelectedX.value,
                                      spotIndex: controller.spotIndex.value,
                                      getTooltipItems: _getToolTipItems,
                                      onPressDot: (value, spotIndex, dateTime) {
                                        controller.chartSelectedX.value = value;
                                        controller.spotIndex.value = spotIndex;
                                        controller.currentBMI.value =
                                            controller.bmiList[spotIndex];
                                      },
                                      maxY: 300,
                                      minY: 10)
                                  : LineChartTitleWidget(
                                      title: TranslationConstants.bmi.tr,
                                      minDate: controller.chartMinDate.value,
                                      maxDate: controller.chartMaxDate.value,
                                      listChartData:
                                          controller.bmiChartListData,
                                      maxY: 50,
                                      minY: 5,
                                      buildLeftTitle: _buildLeftTitleBMIChart,
                                      getTooltipItems: _getToolTipItems,
                                      onPressDot: (value, spotIndex, date) {
                                        controller.chartSelectedX.value = value;
                                        controller.spotIndex.value = spotIndex;
                                        controller.currentBMI.value =
                                            controller.bmiList[spotIndex];
                                      },
                                      selectedX:
                                          controller.chartSelectedX.value,
                                      spotIndex: controller.spotIndex.value,
                                    ),
                              SizedBox(height: 24.0.sp),

                              Obx(
                                () => BMIDetailWidget(
                                    date: DateFormat(
                                      'MMM dd, yyyy',
                                      appController.currentLocale.languageCode,
                                    ).format(DateTime.now()),
                                    time: DateFormat(
                                            'hh:mm a',
                                            appController
                                                .currentLocale.languageCode)
                                        .format(DateTime.now()),
                                    bmi: controller.currentBMI.value.bmi ?? 0,
                                    weight: controller.currentBMI.value.weightKg
                                        .toInt(),
                                    height: controller.currentBMI.value.heightCm
                                        .toInt(),
                                    bmiType: controller.currentBMI.value.type,
                                    onEdit: controller.onEditBMI,
                                    onDelete: controller.onDeleteBMI),
                              ),
                              SizedBox(
                                height: 16.sp,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: EmptyWidget(
                            imagePath: AppImage.iosWeightBMI,
                            message: TranslationConstants
                                .addYourRecordToSeeStatistics.tr,
                            isPremium:
                                Get.find<AppController>().isPremiumFull.value,
                            imageWidth: 0.37 * Get.width),
                      );
                    }
                  })),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp)
                          .copyWith(bottom: 16.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child: SetAlarmButton(
                                  onPress: controller.onSetAlarm)),
                          SizedBox(
                            width: 20.0.sp,
                          ),
                          Expanded(
                              child: HandleSafeAndAdd(
                                  onPress: controller.onAddData)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftTitleBMIChart(double value, TitleMeta mate) {
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      case 20:
        text = '20';
        break;
      case 25:
        text = '25';
        break;
      case 30:
        text = '30';
        break;
      case 35:
        text = '35';
        break;
      case 40:
        text = '40';
        break;
      case 45:
        text = '45';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Text(text,
        style: textStyle12500().copyWith(color: const Color(0xFF6E6E6E)),
        textAlign: TextAlign.center);
  }

  Widget _buildLeftTitleWeightChart(double value, TitleMeta meta) {
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

    return Text(text,
        style: textStyle12500().copyWith(color: const Color(0xFF6E6E6E)),
        textAlign: TextAlign.center);
  }

  List<LineTooltipItem?> _getToolTipItems(List<LineBarSpot> lineBarSpots) {
    return lineBarSpots.map((lineBarSpot) {
      final bmiMap = controller.bmiChartListData[lineBarSpot.spotIndex];
      final int bmi = bmiMap["value"];
      final BMIType bmiType = BMITypeEnum.getBMITypeByValue(bmi);
      return LineTooltipItem(
        bmiType.bmiName,
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }
}

import 'package:bloodpressure/domain/enum/blood_pressure_type.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/blood_pressure_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/widget/systolic_diastolic_widget.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/container_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/picker_time_and_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../theme/app_color.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_touchable.dart';
import '../../widget/home_bar_chart_widget/home_bar_chart.dart';

class BloodPressureDataWidget
    extends GetView<BloodPressureController> {
  const BloodPressureDataWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [


        SizedBox(
          height: 16.sp,
        ),
        Obx(
          () => SystolicDiastolicWidget(
            systolicMin: controller.sysMin.value,
            systolicMax: controller.sysMax.value,
            diastolicMin: controller.diaMin.value,
            diastolicMax: controller.diaMax.value,
          ),
        ),
        SizedBox(
          height: 16.sp,
        ),
        ContainerWidget(
          padding:
              EdgeInsets.all(7.sp).copyWith(top: 10.sp),
          height: 0.63 * Get.width,
          width: double.maxFinite,
          child: Obx(
            () => HomeBarChart(
              minDate: controller.chartMinDate.value,
              maxDate: controller.chartMaxDate.value,
              listChartData:
                  controller.bloodPressureChartData,
              currentSelected:
                  controller.chartXValueSelected.value,
              onSelectChartItem:
                  controller.onSelectedBloodPress,
              groupIndexSelected:
                  controller.chartGroupIndexSelected.value,
              minY: 10,
              maxY: 350,
              horizontalInterval: 50,
            ),
          ),
        ),
        ButtonIos3D.onlyInner(
          backgroundColor: Colors.white,
          innerColor: const Color(0xFF89C7FF),
          radius: 16,
          offsetInner: const Offset(0, 0),
          onPress: controller.onEdit,
          child: Container(
            width: Get.width,
            height: 0.24 * Get.width,
            padding:
                EdgeInsets.all(14.sp),

            child: Obx(
              () => Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat(
                            'MMM dd, yyyy',
                            appController
                                .currentLocale.languageCode,
                          ).format(
                            DateTime
                                .fromMillisecondsSinceEpoch(
                                    controller
                                        .bloodPressSelected
                                        .value
                                        .dateTime!),
                          ),
                          style: textStyle14500().copyWith(
                            color: const Color(0xFF646464),
                          ),
                        ),
                        Text(
                          DateFormat(
                                  'hh:mm a',
                                  appController.currentLocale
                                      .languageCode)
                              .format(
                            DateTime
                                .fromMillisecondsSinceEpoch(
                                    controller
                                        .bloodPressSelected
                                        .value
                                        .dateTime!),

                          ),
                          style: textStyle14500().copyWith(
                            color: const Color(0xFF646464),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${controller.bloodPressSelected.value.systolic}',
                            style: textStyle30600().copyWith(
                              color: const Color(0xFF646464),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${controller.bloodPressSelected.value.diastolic}',
                            style: textStyle30600().copyWith(
                              color: const Color(0xFF646464),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.heart_fill,
                          color:  controller
                              .bloodPressSelected
                              .value
                              .bloodType
                              .colorText,
                        ),
                        Expanded(
                          child: Container(
                            width: 60.0.sp,
                            child: Text(
    controller.bloodPressSelected
        .value.bloodType.name,
                              style: const TextStyle(
                                  overflow: TextOverflow.visible,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF646464)),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: controller.onPressDeleteData,
                            child: const Icon(
                              CupertinoIcons.delete_solid,
                              color: Color(0xFFFF7070),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

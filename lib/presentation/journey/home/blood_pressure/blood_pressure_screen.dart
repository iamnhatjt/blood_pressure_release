import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/blood_pressure_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/widget/blood_pressure_data_widget.dart';
import 'package:bloodpressure/presentation/journey/home/widget/alarm_add_data_button.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/filter/filter_date_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/constants/app_image.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../widget/empty_widget.dart';

class BloodPressureScreen extends GetView<BloodPressureController> {
  const BloodPressureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return AppContainer(
      isShowBanner: false,
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.bloodPressure.tr,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x40000000),
                  offset: Offset(0, 4.0.sp),
                  blurRadius: 4.0.sp,
                ),
              ],
            ),
            titleStyle: IosTextStyle.StyleHeaderApp,
            leftWidget: const IosLeftHeaderWidget(),
            rightWidget: const IosRightHeaderWidget(),
            extendWidget: Obx(() => FilterDateWidget(
                  startDate: controller.filterStartDate.value,
                  endDate: controller.filterEndDate.value,
                  onPressed: () => controller.onPressDateRange(
                    context,
                    callback: controller.filterBloodPressure,
                  ),
                )),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.sp),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() => controller.bloodPressures.isNotEmpty
                        ? SingleChildScrollView(
                            physics:
                                Get.find<AppController>().isPremiumFull.value
                                    ? const NeverScrollableScrollPhysics()
                                    : null,
                            child: const BloodPressureDataWidget())
                        : EmptyWidget(
                            imagePath: AppImage.ic_blood_pressure2,
                            imageWidth: 168.sp,
                            isPremium:
                                Get.find<AppController>().isPremiumFull.value,
                            message: TranslationConstants
                                .addYourRecordToSeeStatistics.tr)),
                  ),
                  AlarmAddDataButton(
                    onSetAlarm: controller.onSetAlarm,
                    onAddData: controller.onAddData,
                  ),
                  SizedBox(
                    height: paddingBottom + 16.sp,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

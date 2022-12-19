import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/home/widget/alarm_add_data_button.dart';
import 'package:bloodpressure/presentation/journey/home/widget/empty_widget.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/blood_header_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/filter/filter_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'blood_sugar_controller.dart';
import 'widgets/filter_state_widget.dart';
import 'widgets/select_state_dialog.dart';

Future showStateDialog(BuildContext context, Function(String) onSelected, RxString rxSelectedState) =>
    showAppDialog(context, TranslationConstants.bloodSugarState.tr, '',
        widgetBody: SelectStateDialog(onSelected: onSelected, rxSelectedState: rxSelectedState,), firstButtonText: 'OK');

class BloodSugarScreen extends GetView<BloodSugarController> {
  const BloodSugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      child: Column(
        children: [
          BloodHeaderWidget(
            title: TranslationConstants.bloodSugar.tr,
            background: AppColor.deepViolet,
            extendWidget: Column(
              children: [
                Obx(() => FilterDateWidget(
                      startDate: controller.filterStartDate.value,
                      endDate: controller.filterEndDate.value,
                      onPressed: () => controller.onPressDateRange(context),
                    )),
                FilterStateWidget(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: EmptyWidget(
                imagePath: AppImage.ic_blood_sugar_empty_data,
                imageWidth: 120.sp,
                message: TranslationConstants.addYourRecordToSeeStatistics.tr,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.sp),
            child: AlarmAddDataButton(
              onSetAlarm: controller.onSetAlarm,
              onAddData: controller.onAddData,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 16.sp,
          )
        ],
      ),
    );
  }
}

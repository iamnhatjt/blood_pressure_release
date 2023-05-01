import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/blood_pressure_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/widget/blood_pressure_data_widget.dart';
import 'package:bloodpressure/presentation/journey/home/widget/alarm_add_data_button.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/filter/filter_date_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/picker_time_and_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants/app_image.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/ios_cofig_widget/widget_buton_handle_data.dart';
import '../widget/empty_widget.dart';

class BloodPressureScreen extends GetView<BloodPressureController> {
  const BloodPressureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();

    controller.context = context;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return AppContainer(
      isShowBanner: true,
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.bloodPressure.tr,

            titleStyle: IosTextStyle.StyleHeaderApp,
            leftWidget: const IosLeftHeaderWidget(),
            rightWidget: const IosRightHeaderWidget(),
            // extendWidget: Obx(() => FilterDateWidget(
            //       startDate: controller.filterStartDate.value,
            //       endDate: controller.filterEndDate.value,
            //       onPressed: () => controller.onPressDateRange(
            //         context,
            //         callback: controller.filterBloodPressure,
            //       ),
            //     )),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.sp),
              child: Column(
                children: [
                  PickTimeAndExport(
                      isChart: controller.bloodPressures.isNotEmpty
                      ,pickerTimeClick: (){
                        () => controller.onPressDateRange(
                                context,
                                callback: controller.filterBloodPressure,
                              );
                  }, textTime: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0.sp, horizontal: 20.0.sp),
                    child: Text(
                        '${DateFormat(
                          'MMM dd, yyyy',
                          appController.currentLocale.languageCode,
                        ).format(controller.filterStartDate.value)} - ${DateFormat(
                          'MMM dd, yyyy',
                          appController.currentLocale.languageCode,
                        ).format(controller.filterEndDate.value)}', style: IosTextStyle.IosTextPickTime,
                    ),
                  ), exportClick: controller.onExportData)
                  ,
                 Obx(()=>  Expanded(
                   child: Container(

                     padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                     decoration: BoxDecoration(
                       color: controller.bloodPressures.isNotEmpty? const Color(0xFFF4FAFF): Colors.transparent,
                       borderRadius: BorderRadius.only(
                         bottomRight: Radius.circular(10.0.sp),
                         bottomLeft: Radius.circular(10.0.sp),
                       ),
                     ),
                     child: Obx(() => controller.bloodPressures.isNotEmpty
                         ? SingleChildScrollView(
                         physics:
                         Get.find<AppController>().isPremiumFull.value
                             ? const NeverScrollableScrollPhysics()
                             : null,
                         child: const BloodPressureDataWidget())
                         : EmptyWidget(
                         imagePath: AppImage.iosBloodPressure,
                         imageWidth: 168.sp,
                         isPremium:
                         Get.find<AppController>().isPremiumFull.value,
                         message: TranslationConstants
                             .addYourRecordToSeeStatistics.tr)),
                   ),
                 ),),
                  SizedBox(
                    height: 68.0.sp,
                  ),
                  Row(
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

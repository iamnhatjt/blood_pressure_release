import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/widget/alarm_add_data_button.dart';
import 'package:bloodpressure/presentation/journey/home/widget/empty_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/blood_header_widget.dart';
import 'package:bloodpressure/presentation/widget/filter/filter_date_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/picker_time_and_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widget/ios_cofig_widget/widget_buton_handle_data.dart';
import 'blood_sugar_controller.dart';
import 'widgets/blood_sugar_data_widget.dart';
import 'widgets/filter_state_widget.dart';
import 'widgets/select_state_dialog.dart';

Future showStateDialog(BuildContext context, Function(String) onSelected, RxString rxSelectedState) =>
    showAppDialog(context, TranslationConstants.bloodSugarState.tr, '',
        widgetBody: SelectStateDialog(
          onSelected: onSelected,
          rxSelectedState: rxSelectedState,
        ),
        firstButtonText: 'OK');

class BloodSugarScreen extends GetView<BloodSugarController> {
  const BloodSugarScreen({super.key});


  Widget headerBloodSugar(){
    return Obx(
          () => BloodHeaderWidget(
        title: TranslationConstants.bloodSugar.tr,
        background: AppColor.deepViolet,
        onExported: controller.onExportData,
        extendWidget: const SizedBox.shrink(),
        isLoading: controller.exportLoaded.value == LoadedType.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(

      isShowBanner: true,
      child: Column(
        children: [
          //header blood_sugaer
          headerBloodSugar(),
          Obx(() {
            final appController = Get.find<AppController>();

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0.sp),
              child: PickTimeAndExportSugar(
                isChart: !controller.rxIsEmptyList.value
                ,pickerTimeClick: (){
                controller.onSelectedDateTime();
              }, textTime: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0.sp, horizontal: 20.0.sp),
                child: Text( '${DateFormat(
                  'MMM dd, yyyy',
                  appController.currentLocale.languageCode,
                ).format(controller.filterStartDate.value)} - ${DateFormat(
                  'MMM dd, yyyy',
                  appController.currentLocale.languageCode,
                ).format(controller.filterEndDate.value)}', style: IosTextStyle.IosTextPickTime,),
              ), exportClick: controller.onExportData,

              ),
            );
          }),


          Obx(()=> Expanded(
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom:  Radius.circular(16)),
                color:  !controller.rxIsEmptyList.value? Color(0xFFF4FAFF) : Colors.transparent,

              ),
              margin: EdgeInsets.symmetric(horizontal: 8.0.sp),
              child: Obx(
                    () {
                  if (controller.rxIsEmptyList.value == false) {
                    return BloodSugarDataWidget();
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: EmptyWidget(
                      imagePath: AppImage.iosBloodSugar,
                      imageWidth: 120.sp,
                      message: TranslationConstants.addYourRecordToSeeStatistics.tr,
                      isPremium: Get.find<AppController>().isPremiumFull.value,
                    ),
                  );
                },
              ),
            ),
          ),),
          SizedBox(height: 32.0.sp,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.sp),
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




          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 16.sp,
          )
        ],
      ),
    );
  }
}

import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_tile.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AlarmScreen extends GetView<AlarmController> {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.alarm.tr,
            leftWidget: SizedBox(width: 40.0.sp),
            rightWidget: controller.isPremiumFull.value
                ? null
                : AppTouchable(
                    onPressed: () {
                      controller.onSubScriblePremium();
                    },
                    child: Image.asset(
                      AppImage.ic_premium,
                      height: 36.0.sp,
                    )),
            titleStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Obx(() {
            if (controller.isPremiumFull.value) {
              return SizedBox.shrink();
            } else {
              return AppTouchable.common(
                onPressed: null,
                margin: EdgeInsets.symmetric(
                    horizontal: 17.0.sp, vertical: 12.0.sp).copyWith(bottom: 0),
                height: 200.0.sp,
                width: Get.width,
                child: Text(
                  'ads',
                  style: textStyle20500(),
                ),
              );
            }
          }),
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == controller.alarmList.length) {
                      return SizedBox(height: 102.0.sp,);
                    }

                    final alarmModel = controller.alarmList[index];
                    return AlarmTile(
                      alarmModel: alarmModel,
                      onDeleteTap: controller.onPressDeleteAlarm,
                      onTap: (alarmModel) => controller.onEditAlarm(
                          context: context, alarmModel: alarmModel),
                    );
                  },
                  itemCount: controller.alarmList.length + 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

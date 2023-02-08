import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_tile.dart';
import 'package:bloodpressure/presentation/journey/main/widgets/subscribe_button.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/native_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AlarmScreen extends GetView<AlarmController> {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      isShowBanner: false,
      child: Column(
        children: [
          Obx(
            () => AppHeader(
              title: TranslationConstants.alarm.tr,
              leftWidget: SizedBox(width: 40.0.sp),
              rightWidget: SubscribeButton(
                  isPremiumFull: Get.find<AppController>().isPremiumFull.value),
              titleStyle: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Obx(
            () => NativeAdsWidget(
              factoryId: NativeFactoryId.appNativeAdFactorySmall,
              isPremium: Get.find<AppController>().isPremiumFull.value,
              height: 120.0.sp,
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.alarmList.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(48.0.sp),
                    child: Center(
                      child: Text(
                        TranslationConstants.noAlarm.tr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero.copyWith(top: 12.0.sp),
                  itemBuilder: (context, index) {
                    if (index == controller.alarmList.length) {
                      return SizedBox(
                        height: 102.0.sp,
                      );
                    }

                    final alarmModel = controller.alarmList[index];
                    return AlarmTile(
                      alarmModel: alarmModel,
                      onDeleteTap: controller.onPressDeleteAlarm,
                      onTap: (alarmModel) =>
                          controller.onPressEditAlarm(context, alarmModel),
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

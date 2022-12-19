import 'package:bloodpressure/presentation/journey/alarm/alarm_screen.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import '../home/home_screen.dart';
import '../setting/setting_screen.dart';
import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      alignLayer: AlignmentDirectional.bottomEnd,
      coverScreenWidget: Obx(() {
        return AnimatedSwitcher(duration: const Duration(milliseconds: 260), child:
             controller.currentTab.value != 2 ? const SizedBox.shrink() : const AddAlarmButton(),
        );
      },),
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: controller.currentTab.value,
            children: [
              const HomeScreen(),
              Container(),
              const AlarmScreen(),
              const SettingScreen(),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.red,
            onTap: controller.onPressTab,
            currentIndex: controller.currentTab.value,
            unselectedItemColor: AppColor.white.withOpacity(0.5),
            unselectedFontSize: 16.0.sp,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            selectedItemColor: AppColor.white,
            selectedFontSize: 16.0.sp,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            items: [
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                    path: AppImage.ic_home,
                    color: controller.currentTab.value == 0
                        ? AppColor.white
                        : AppColor.white.withOpacity(0.5)),
                label: TranslationConstants.home.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                    path: AppImage.ic_insight,
                    color: controller.currentTab.value == 1
                        ? AppColor.white
                        : AppColor.white.withOpacity(0.5)),
                label: TranslationConstants.insights.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                    path: AppImage.ic_alarm,
                    color: controller.currentTab.value == 2
                        ? AppColor.white
                        : AppColor.white.withOpacity(0.5)),
                label: TranslationConstants.alarm.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                    path: AppImage.ic_setting,
                    color: controller.currentTab.value == 3
                        ? AppColor.white
                        : AppColor.white.withOpacity(0.5)),
                label: TranslationConstants.setting.tr.toUpperCase(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

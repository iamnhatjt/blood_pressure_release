import 'package:bloodpressure/app/ui/screen/tab/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';
import '../../res/image/app_image.dart';
import '../../res/string/app_strings.dart';
import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_image_widget.dart';
import 'tab/setting_tab.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: controller.currentTab.value,
            children: [
              const HomeTab(),
              Container(),
              Container(),
              const SettingTab(),
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
                    color: controller.currentTab.value == 0 ? AppColor.white : AppColor.white.withOpacity(0.5)),
                label: StringConstants.home.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                    path: AppImage.ic_insight,
                    color: controller.currentTab.value == 1 ? AppColor.white : AppColor.white.withOpacity(0.5)),
                label: StringConstants.insights.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                    path: AppImage.ic_alarm,
                    color: controller.currentTab.value == 2 ? AppColor.white : AppColor.white.withOpacity(0.5)),
                label: StringConstants.alarm.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                    path: AppImage.ic_setting,
                    color: controller.currentTab.value == 3 ? AppColor.white : AppColor.white.withOpacity(0.5)),
                label: StringConstants.setting.tr.toUpperCase(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

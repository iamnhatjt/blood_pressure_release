import 'package:bloodpressure/app/controller/heart_beat_controller.dart';
import 'package:bloodpressure/app/ui/theme/app_color.dart';
import 'package:bloodpressure/app/ui/widget/app_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/image/app_image.dart';
import '../../res/string/app_strings.dart';
import '../../util/disable_ glow_behavior.dart';
import '../widget/app_header.dart';
import '../widget/app_image_widget.dart';
import '../widget/app_style.dart';
import '../widget/app_touchable.dart';

class HeartBeatScreen extends GetView<HeartBeatController> {
  const HeartBeatScreen({Key? key}) : super(key: key);

  Widget _buildBodyEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppImageWidget.asset(
          path: AppImage.ic_heart_rate_2,
          width: Get.width / 3,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(67.0.sp, 40.0.sp, 67.0.sp, 0),
          child: Text(
            StringConstants.measureNowOrAdd.tr,
            textAlign: TextAlign.center,
            style: textStyle20700().merge(const TextStyle(color: AppColor.black)),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyData() {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(17.0.sp),
        child: Column(
          children: [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(children: [
        AppHeader(
          title: StringConstants.heartRate.tr,
          decoration: BoxDecoration(
            color: AppColor.red,
            boxShadow: [
              BoxShadow(
                color: const Color(0x40000000),
                offset: Offset(0, 4.0.sp),
                blurRadius: 4.0.sp,
              ),
            ],
          ),
          leftWidget: AppTouchable(
            width: 40.0.sp,
            height: 40.0.sp,
            padding: EdgeInsets.all(2.0.sp),
            onPressed: Get.back,
            outlinedBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0.sp),
            ),
            child: AppImageWidget.asset(
              path: AppImage.ic_back,
              color: AppColor.white,
            ),
          ),
          rightWidget: AppTouchable(
            width: 40.0.sp,
            height: 40.0.sp,
            onPressed: () {},
            outlinedBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0.sp),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                StringConstants.export.tr,
                style: textStyle18400().merge(const TextStyle(color: AppColor.white)),
              ),
            ),
          ),
          titleStyle: const TextStyle(color: AppColor.white),
          extendWidget: AppTouchable(
            height: 40.0.sp,
            width: Get.width,
            margin: EdgeInsets.fromLTRB(27.0.sp, 14.0.sp, 27.0.sp, 0),
            onPressed: () {},
            outlinedBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(87.0.sp),
            ),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(87.0.sp),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x80000000),
                  offset: const Offset(0, 0),
                  blurRadius: 4.0.sp,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 44.0.sp),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Dec 20, 2022 - Dec 28, 2022',
                      style: textStyle18400(),
                    ),
                  ),
                ),
                AppImageWidget.asset(path: AppImage.ic_filter, width: 40.0.sp),
                SizedBox(width: 4.0.sp),
              ],
            ),
          ),
        ),
        Expanded(
          child: _buildBodyEmpty(),
        ),
        AppTouchable.common(
          onPressed: () {},
          height: 70.0.sp,
          backgroundColor: AppColor.green,
          margin: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 12.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImageWidget.asset(
                path: AppImage.ic_heart_rate,
                width: 60.0.sp,
              ),
              SizedBox(width: 8.0.sp),
              Text(
                StringConstants.measureNow.tr,
                style: textStyle24700(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0.sp),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: AppTouchable.common(
                  onPressed: () {},
                  height: 70.0.sp,
                  backgroundColor: AppColor.gold,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImageWidget.asset(
                        path: AppImage.ic_alarm,
                        width: 40.0.sp,
                        color: AppColor.black,
                      ),
                      Text(
                        StringConstants.setAlarm.tr,
                        style: textStyle18700(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.0.sp),
              Expanded(
                flex: 5,
                child: AppTouchable.common(
                  onPressed: () {},
                  height: 70.0.sp,
                  backgroundColor: AppColor.primaryColor,
                  child: Text(
                    '+ ${StringConstants.addData.tr}',
                    style: textStyle20700(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 17.0.sp),
      ]),
    );
  }
}

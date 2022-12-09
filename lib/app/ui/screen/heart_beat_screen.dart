import 'package:bloodpressure/app/controller/heart_beat_controller.dart';
import 'package:bloodpressure/app/ui/theme/app_color.dart';
import 'package:bloodpressure/app/ui/widget/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../res/image/app_image.dart';
import '../../res/string/app_strings.dart';
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
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
          margin: EdgeInsets.symmetric(horizontal: 17.0.sp, vertical: 16.0.sp),
          decoration: commonDecoration(),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      StringConstants.average.tr,
                      style: textStyle18400(),
                    ),
                    Obx(() => Text(
                          '${controller.hrAvg.value}',
                          style: textStyle22700(),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      StringConstants.min.tr,
                      style: textStyle18400(),
                    ),
                    Obx(() => Text(
                          '${controller.hrMin.value}',
                          style: textStyle22700(),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      StringConstants.max.tr,
                      style: textStyle18400(),
                    ),
                    Obx(() => Text(
                          '${controller.hrMax.value}',
                          style: textStyle22700(),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
            margin: EdgeInsets.symmetric(horizontal: 17.0.sp),
            decoration: commonDecoration(),
          ),
        ),
        Container(
          height: 79.0.sp,
          width: Get.width,
          padding: EdgeInsets.only(top: 7.0.sp, left: 14.0.sp, right: 4.0.sp),
          margin: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 8.0.sp),
          decoration: const BoxDecoration(
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage(AppImage.ic_box)),
          ),
          child: Obx(() {
            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(controller.currentHeartRateModel.value.timeStamp ?? 0);
            int value = controller.currentHeartRateModel.value.value ?? 40;
            String status = '';
            Color color = AppColor.primaryColor;
            if (value < 60) {
              status = StringConstants.slow.tr;
              color = AppColor.violet;
            } else if (value > 100) {
              status = StringConstants.fast.tr;
              color = AppColor.red;
            } else {
              status = StringConstants.normal.tr;
              color = AppColor.green;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM dd, yyyy').format(dateTime),
                      style: textStyle14500(),
                    ),
                    SizedBox(height: 2.0.sp),
                    Text(
                      DateFormat('h:mm a').format(dateTime),
                      style: textStyle14500(),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$value',
                      style: TextStyle(
                        fontSize: 37.0.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(height: 2.0.sp),
                    Text(
                      'BPM',
                      style: textStyle14500().merge(const TextStyle(height: 1)),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 7.0.sp),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                  child: Text(
                    status,
                    style: textStyle20700(),
                  ),
                ),
                AppTouchable(
                  width: 40.0.sp,
                  height: 40.0.sp,
                  onPressed: () {},
                  child: AppImageWidget.asset(
                    path: AppImage.ic_del,
                  ),
                ),
              ],
            );
          }),
        ),
        SizedBox(height: 4.0.sp),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
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
            onPressed: controller.onPressDateRange,
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
                    child: Obx(() => Text(
                          '${DateFormat('MMM dd, yyyy').format(controller.startDate.value)} - ${DateFormat('MMM dd, yyyy').format(controller.endDate.value)}',
                          style: textStyle18400(),
                        )),
                  ),
                ),
                AppImageWidget.asset(path: AppImage.ic_filter, width: 40.0.sp),
                SizedBox(width: 4.0.sp),
              ],
            ),
          ),
        ),
        Expanded(
          child: Obx(() => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.red,
                  ),
                )
              : controller.listHeartRateModel.value.isEmpty
                  ? _buildBodyEmpty()
                  : _buildBodyData()),
        ),
        AppTouchable.common(
          onPressed: controller.onPressMeasureNow,
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

import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/insight/insight_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:bloodpressure/common/constants/app_image.dart';

class InsightScreen extends GetView<InsightController> {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.insights.tr,
            leftWidget: SizedBox(width: 40.0.sp),
            rightWidget: Get.find<AppController>().isPremiumFull.value
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
            if (Get.find<AppController>().isPremiumFull.value) {
              return const SizedBox.shrink();
            } else {
              return AppTouchable.common(
                onPressed: null,
                margin:
                    EdgeInsets.symmetric(horizontal: 17.0.sp, vertical: 12.0.sp)
                        .copyWith(bottom: 0),
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
            child: ListView.builder(
              itemCount: controller.contents.length,
              itemBuilder: (context, index) {
                final content = controller.contents[index];
                return AppTouchable.common(
                  onPressed: null,
                  margin: EdgeInsets.symmetric(
                          horizontal: 17.0.sp, vertical: 12.0.sp)
                      .copyWith(bottom: 0),
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0.sp, vertical: 28.0.sp),
                  width: Get.width,
                  child: Row(
                    children: [
                      Image.asset(
                        content["image"],
                        width: 50.0.sp,
                      ),
                      SizedBox(
                        width: 14.0.sp,
                      ),
                      Text(
                        content["text"],
                        style: textStyle20700().copyWith(
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:bloodpressure/common/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/constants/app_image.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import 'intro_controller.dart';

class IntroScreen extends GetView<IntroController> {

  @override
  Widget build(BuildContext context) {
    List<String> imagesPath = [
      AppImage.iosIntro1,
      AppImage.iosIntro2,
      AppImage.iosIntro3,
      AppImage.iosIntro4,
    ];
    List<String> enSub = [
      'Track your progress with \n BMI calculator',
      'Your pocket heart rate monitor',
      'Improve health with \n Vital signs Journal',
      'Check your heart rate now!'
    ];
    List<String> vieSub = [
      'Theo dõi tiến trình của bạn với máy tính chỉ số BMI'
          'Máy đo nhịp tim bỏ túi của bạn',
      'Cải thiện sức khỏe với tạp \n chí dấu hiệu sinh tồn',
      'Kiểm tra nhịp tim của bạn bây giờ!',
    ];




    return AppContainer(
        isShowBanner: false,
        backgroundColor: Colors.white,
        child: Obx(()=> Column(
          children: [
            SizedBox(
              height: 24.0.sp,
            ),
            AppImageWidget.asset(height: Get.height * 0.4, path: imagesPath[controller.pageIndex.value]),
            controller.pageIndex.value == 0
                ? Column(
              children: [
                SizedBox(
                  height: 20.0.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppImageWidget.asset(path: AppImage.eatIntro1, height: 94.0.sp),
                    AppImageWidget.asset(path: AppImage.eatIntro2, height: 94.0.sp),
                    AppImageWidget.asset(path: AppImage.eatIntro3, height: 94.0.sp),
                  ],
                )
              ],
            )
                : const SizedBox.shrink(),
            const Spacer(),
            SizedBox(
              width: Get.width * 0.86,
              child: Text(
                chooseContentByLanguage(enSub[controller.pageIndex.value], enSub[controller.pageIndex.value]),
                style: TextStyle(
                  fontSize: 22.0.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 32.0.sp,
            ),
            Center(
              child: Container(
                width: Get.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      4,
                          (i) => AppImageWidget.asset(
                        path: controller.pageIndex.value == i ? AppImage.dotIntroSelect : AppImage.dotIntro,
                        height: 12,
                      )).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 32.0.sp,
            ),
            GestureDetector(
              onTap: controller.movePage,
              child: Center(
                child: Container(
                  height: 60.0.sp,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF68DF55), Color(0xFF31A714)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        // BoxShadow(
                        //   spreadRadius: -1,
                        //   blurRadius: 4,
                        //   offset: Offset(0, -5),
                        //   color: Colors.black.withOpacity(0.15),
                        // ),

                      ]),
                  child: Center(
                    child: Text(
                      controller.pageIndex.value != 3
                          ? TranslationConstants.next.tr
                          : chooseContentByLanguage(
                          'Get your first meansure', 'kiểm tra nhịp tim của bạn'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0.sp,
            ),
          ],
        ),)
    );
  }
}
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/disable_glow_behavior.dart';
import '../../common/util/translation/app_translation.dart';
import '../journey/home/heart_beat/heart_beat_controller.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_button.dart';
import 'ios_cofig_widget/Button_ios_3d.dart';

class AppDialogAgeWidget extends StatefulWidget {
  final int? initialAge;
  final Function()? onPressCancel;
  final Function(int value)? onPressSave;

  const AppDialogAgeWidget(
      {Key? key, this.initialAge, this.onPressCancel, this.onPressSave})
      : super(key: key);

  @override
  State<AppDialogAgeWidget> createState() => _AppDialogAgeWidgetState();
}

class _AppDialogAgeWidgetState extends State<AppDialogAgeWidget> {
  late FixedExtentScrollController fixedExtentScrollController;
  late int _value;

  @override
  void initState() {
    fixedExtentScrollController =
        FixedExtentScrollController(initialItem: (widget.initialAge ?? 30) - 2);
    _value = widget.initialAge ?? 30;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.0.sp,),
        Container(
          width: 220.0.sp,
          height: 132.0.sp,
          margin: EdgeInsets.symmetric(vertical: 24.0.sp),
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: ButtonIos3D.onlyInner(
              innerColor: const Color(0xFF89C7FF),
              radius: 16,
              innerRadius: 5,
              offsetInner: Offset.zero,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '$_value',
                        style: const TextStyle(
                            color: const Color(0xFF40A4FF),
                            fontSize: 72,
                            fontWeight: FontWeight.w700,
                            height: 9 / 7),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 16.0.sp,),

                      ButtonIos3D(
                        onPress: (){
                          setState(() {
                            _value++;
                          });
                        },
                        innerColor: const Color(0xFF40A4FF).withOpacity(0.25),
                        dropColor: const Color(0xFF40A4FF).withOpacity(0.25),
                        innerRadius: 4,
                        dropRadius: 4,
                        offsetDrop: const Offset(0,-1),
                        offsetInner: const Offset(0,-2),
                        radius: 10,
                        child: Container(
                          padding: EdgeInsets.all(12.0.sp),
                          child: AppImageWidget.asset(
                            path: AppImage.iosUpAge,
                            height: 16.0.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0.sp,),
                      ButtonIos3D(
                        onPress: (){
                          setState(() {
                            _value > 0  ? _value-- : null;
                          });
                        },
                        radius: 10,
                        innerColor: const Color(0xFF40A4FF).withOpacity(0.25),
                        dropColor: const Color(0xFF40A4FF).withOpacity(0.25),
                          innerRadius: 4,
                          dropRadius: 4,
                          offsetDrop: const Offset(0,-1),
                          offsetInner: const Offset(0,-2),
                          child: Container(
                            padding: EdgeInsets.all(12.0.sp),

                            child: AppImageWidget.asset(
                                path: AppImage.iosDownAge, height: 16.0.sp,),
                          ),),
                      SizedBox(height: 16.0.sp,),

                    ],
                  ),
                  SizedBox(width: 16.0.sp,)
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 60.0.sp,),

        Row(
          children: [
            Expanded(
              child: ButtonIos3D(
                onPress: () {
                  widget.onPressCancel!();
                  Get.find<HeartBeatController>().onPressAddData();
                },
                height: 60.0.sp,
                width: Get.width,
                backgroundColor: const Color(0xFFFF6464),
                radius: 20.0.sp,
                dropRadius: 10,
                offsetDrop: Offset.zero,
                dropColor: Colors.black.withOpacity(0.25),
                innerColor: Colors.black.withOpacity(0.25),
                innerRadius: 4,
                offsetInner: const Offset(0, -4),
                child: Center(
                  child: Text(
                    TranslationConstants.cancel.tr,
                    textAlign: TextAlign.center,
                    style: textStyle24700(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: ButtonIos3D(
                onPress: () {
                  print('on save');
                  widget.onPressSave!(_value);
                  Get.find<HeartBeatController>().onPressAddData();
                },
                height: 60.0.sp,
                width: Get.width,
                // text: firstButtonText,
                backgroundColor: const Color(0xFF5298EB),
                dropRadius: 10,
                offsetDrop: Offset.zero,
                dropColor: Colors.black.withOpacity(0.25),
                innerColor: Colors.black.withOpacity(0.25),
                innerRadius: 4,
                offsetInner: const Offset(0, -4),
                radius: 20.0.sp,
                child: Center(
                  child: Text(
                    TranslationConstants.save.tr,
                    textAlign: TextAlign.center,
                    style: textStyle24700(),
                  ),
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}

import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Button_ios_3d.dart';

class SetAlarmButton extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final Function() onPress;

  const SetAlarmButton(
      {Key? key, this.child, required this.onPress, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonIos3D(
        onPress: onPress,
        dropColor: Colors.black.withOpacity(0.25),
        // dropRadius:,
        innerColor: Colors.black.withOpacity(0.15),
        offsetDrop: const Offset(0, 0),
        offsetInner: const Offset(0, -4),
        innerRadius: 4,
        dropRadius: 10,
        child: Container(
          height: 80.0.sp,
          child: child ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImageWidget.asset(
                    path: AppImage.iosSetalarm,
                    height: 24.0.sp,
                  ),
                  SizedBox(
                    height: 4.0.sp,
                  ),
                  Text(
                    TranslationConstants.setAlarm.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 30 / 24,
                        color: Color(0xFF3E96E6)),
                  )
                ],
              ),
        ));
  }
}

class HandleSafeAndAdd extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final Function() onPress;

  const HandleSafeAndAdd({
    Key? key,
    this.child,
    required this.onPress,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonIos3D(
      backgroundColor: const Color(0xFF5298EB),
        onPress: onPress,
        dropColor: Colors.black.withOpacity(0.25),
        // dropRadius:,
        innerColor: Colors.black.withOpacity(0.15),
        offsetDrop: const Offset(0, 0),
        offsetInner: const Offset(0, -4),
        innerRadius: 4,
        dropRadius: 10,
        child: Container(
          height: 80.0.sp,
          child: child ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImageWidget.asset(
                    path: AppImage.iosAddData,
                    height: 24.0.sp,
                  ),
                  SizedBox(
                    height: 4.0.sp,
                  ),
                  Text(
                    TranslationConstants.addData.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 30 / 24,
                        color: Colors.white),
                  )
                ],
              ),
        ));
  }
}

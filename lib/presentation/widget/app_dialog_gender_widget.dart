import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/presentation/journey/home/heart_beat/heart_beat_controller.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constants/app_image.dart';
import '../../common/util/app_util.dart';
import '../../common/util/translation/app_translation.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_button.dart';
import 'app_image_widget.dart';
import 'app_touchable.dart';

class AppDialogGenderWidget extends StatefulWidget {
  final Map? initialGender;
  final Function()? onPressCancel;
  final Function(Map value)? onPressSave;

  const AppDialogGenderWidget(
      {Key? key, this.initialGender, this.onPressCancel, this.onPressSave})
      : super(key: key);

  @override
  State<AppDialogGenderWidget> createState() => _AppDialogGenderWidgetState();
}

class _AppDialogGenderWidgetState extends State<AppDialogGenderWidget> {
  late Map _value;

  @override
  void initState() {
    _value = widget.initialGender ?? AppConstant.listGender[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 28.0.sp),
        for (int i = 0; i < AppConstant.listGender.length; i++)
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 28.0.sp),
            child: ButtonIos3D.onlyInner(
              backgroundColor: AppConstant.listGender[i]['id'] == _value['id']
                  ? const Color(0xFF40A4FF)
                  : Colors.white,
              height: 48.0.sp,
              radius: 12,
              onPress: () {
                setState(() {
                  _value = AppConstant.listGender[i];
                });
              },
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.0.sp,
                    ),
                    Text(
                      chooseContentByLanguage(
                          AppConstant.listGender[i]['nameEN'],
                          AppConstant.listGender[i]['nameVN']),
                      style: textStyle20700().merge(TextStyle(
                          color: AppConstant.listGender[i]['id'] == _value['id']
                              ? Colors.white
                              : const Color(0xFF7A7A7A))),
                    ),
                    const Spacer(),
                    AppConstant.listGender[i]['id'] == _value['id']
                        ? AppImageWidget.asset(
                            path: AppImage.iosIcSelect,
                            width: 20.0.sp,
                          )
                        : AppImageWidget.asset(
                            path: AppImage.iosNotIcSelect,
                            width: 20.0.sp,
                          ),
                    SizedBox(
                      width: 16.0.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        SizedBox(height:56.0.sp),
        Row(
          children: [
            Expanded(
              child: ButtonIos3D(
                height: 60.0.sp,
                width: Get.width,
                onPress: () {
                  widget.onPressCancel!();
                },
                backgroundColor: const Color(0xFFFF6464),
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
                height: 60.0.sp,
                width: Get.width,
                onPress: () {
                  widget.onPressSave!(_value);
                },
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

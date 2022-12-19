import 'package:bloodpressure/common/constants/app_constant.dart';
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
        SizedBox(height: 12.0.sp),
        for (int i = 0; i < AppConstant.listGender.length; i++)
          AppTouchable(
            height: 41.0.sp,
            padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
            margin: EdgeInsets.symmetric(vertical: 2.0.sp, horizontal: 8.0.sp),
            decoration: BoxDecoration(
              color: AppConstant.listGender[i]['id'] == _value['id']
                  ? AppColor.primaryColor.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0.sp),
            ),
            onPressed: () {
              setState(() {
                _value = AppConstant.listGender[i];
              });
            },
            child: Row(
              children: [
                Text(
                  chooseContentByLanguage(AppConstant.listGender[i]['nameEN'],
                      AppConstant.listGender[i]['nameVN']),
                  style: textStyle20700().merge(TextStyle(
                      color: AppConstant.listGender[i]['id'] == _value['id']
                          ? AppColor.primaryColor
                          : AppColor.black)),
                ),
                const Spacer(),
                AppConstant.listGender[i]['id'] == _value['id']
                    ? AppImageWidget.asset(
                        path: AppImage.ic_check,
                        width: 20.0.sp,
                      )
                    : Container(
                        width: 20.0.sp,
                        height: 20.0.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0.sp),
                            color: const Color(0xFFD9D9D9)),
                      ),
              ],
            ),
          ),
        SizedBox(height: 22.0.sp),
        Row(
          children: [
            Expanded(
              child: AppButton(
                onPressed: widget.onPressCancel,
                height: 60.0.sp,
                width: Get.width,
                color: AppColor.red,
                radius: 10.0.sp,
                child: Text(
                  TranslationConstants.cancel.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: AppButton(
                height: 60.0.sp,
                width: Get.width,
                onPressed: () => widget.onPressSave!(_value),
                color: AppColor.primaryColor,
                radius: 10.0.sp,
                child: Text(
                  TranslationConstants.save.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

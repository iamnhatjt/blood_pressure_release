import 'dart:io';

import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddDataDialog extends StatelessWidget {
  final RxString rxStrDate;
  final RxString rxStrTime;
  final Widget child;
  final Function() onSelectDate;
  final Function() onSelectTime;
  final Function()? firstButtonOnPressed;
  final bool isEdit;
  final Function()? secondButtonOnPressed;
  final Widget? coverScreenWidget;
  final String? firstButtonText;
  final bool hasScroll;

  const AddDataDialog({
    super.key,
    required this.rxStrDate,
    required this.rxStrTime,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.child,
    this.isEdit = false,
    this.coverScreenWidget,
    this.firstButtonOnPressed,
    this.firstButtonText,
    this.secondButtonOnPressed,
    this.hasScroll = false,
  });

  Widget _buildDateTimeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.sp),
      child: Row(
        children: [
          AppTouchable(
              onPressed: onSelectDate,
              backgroundColor: AppColor.lightGray,
              padding: EdgeInsets.symmetric(
                  vertical: 8.sp, horizontal: 28.sp),
              child: Obx(
                () => Text(
                  rxStrDate.value,
                  style: textStyle18500(),
                ),
              )),
          const Spacer(),
          AppTouchable(
              onPressed: onSelectTime,
              backgroundColor: AppColor.lightGray,
              padding: EdgeInsets.symmetric(
                  vertical: 8.sp, horizontal: 20.sp),
              child: Obx(
                () => Text(
                  rxStrTime.value,
                  style: textStyle18500(),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      firstButtonText: isEdit
          ? TranslationConstants.save.tr
          : TranslationConstants.add.tr,
      firstButtonCallback: () {
        firstButtonOnPressed?.call() ?? Get.back;
      },
      secondButtonText: TranslationConstants.cancel.tr,
      hasScroll: hasScroll,
      secondButtonCallback: () {
        secondButtonOnPressed?.call() ?? Get.back;
      },
      coverScreenWidget: coverScreenWidget,
      widgetBody: InkWell(
        onTap: hideKeyboard,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDateTimeWidget(),
            child,
          ],
        ),
      ),
    );
  }
}

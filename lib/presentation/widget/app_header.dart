import 'dart:io';

import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constants/app_image.dart';
import '../../common/util/translation/app_translation.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_image_widget.dart';
import 'app_touchable.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? hintContent;
  final String? hintTitle;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? middleWidget;
  final Widget? extendWidget;
  final Color? backgroundColor;
  final CrossAxisAlignment? crossAxisAlignmentMainRow;
  final BoxDecoration? decoration;
  final double? additionSpaceButtonLeft;
  final EdgeInsets? padding;

  const AppHeader({
    Key? key,
    this.title,
    this.leftWidget,
    this.rightWidget,
    this.middleWidget,
    this.extendWidget,
    this.crossAxisAlignmentMainRow,
    this.hintContent,
    this.hintTitle,
    this.backgroundColor,
    this.titleStyle,
    this.decoration,
    this.additionSpaceButtonLeft,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.fromLTRB(
              0.0, MediaQuery.of(context).padding.top + 16.0.sp, 0.0, 16.0.sp),
      color: decoration == null ? backgroundColor ?? Colors.transparent : null,
      decoration: decoration,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Stack(
                children: [
              Row(
                crossAxisAlignment:
                    crossAxisAlignmentMainRow ?? CrossAxisAlignment.center,
                children: [
                  leftWidget ??
                      AppTouchable(
                        width: 40.0.sp,
                        height: 40.0.sp,
                        padding: EdgeInsets.all(2.0.sp),
                        onPressed: Get.back,
                        outlinedBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0.sp),
                        ),
                        child: AppImageWidget.asset(
                          path: AppImage.ic_back,
                        ),
                      ),
                  SizedBox(width: additionSpaceButtonLeft ?? 0),
                  Spacer(),
                  rightWidget ?? SizedBox(width: 40.0.sp),
                ],
              ),
              Positioned.fill(
                child: Center(
                  child: middleWidget ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                          height: 25 / 20,
                        ).merge(titleStyle),
                      ),
                ),
              ),
            ]),
          ),
          extendWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  final Color? buttonColor;
  final Function()? onBack;

  const AppBackButton({super.key, this.buttonColor, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      width: 40.0.sp,
      height: 40.0.sp,
      padding: EdgeInsets.all(2.0.sp),
      onPressed: onBack ?? Get.back,
      outlinedBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0.sp),
      ),
      child: AppImageWidget.asset(
        path: AppImage.ic_back,
        color: buttonColor ?? AppColor.white,
      ),
    );
  }
}

class ExportButton extends StatelessWidget {
  final Function()? onPressed;
  final bool isLoading;
  final Color? titleColor;

  const ExportButton(
      {Key? key, this.onPressed, this.isLoading = false, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      width: 80.0.sp,
      height: 28.0.sp,
      onPressed: () {
        if (Platform.isAndroid) {
          showInterstitialAds(() => onPressed?.call());
        } else {
          onPressed?.call();
        }
      },
      outlinedBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0.sp),
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(32.0.sp),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: isLoading
            ? Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Center(
                  child: CircularProgressIndicator(
                    color: titleColor,
                    strokeWidth: 3.0.sp,
                  ),
                ),
              )
            : Text(
                TranslationConstants.export.tr,
                style: textStyle18500()
                    .merge(TextStyle(color: titleColor ?? AppColor.white)),
              ),
      ),
    );
  }
}

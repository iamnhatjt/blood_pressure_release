import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../res/image/app_image.dart';
import '../theme/app_color.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, MediaQuery.of(context).padding.top + 16.0.sp, 0.0, 16.0.sp),
      color: decoration == null ? backgroundColor ?? Colors.transparent : null,
      decoration: decoration,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Row(
              crossAxisAlignment: crossAxisAlignmentMainRow ?? CrossAxisAlignment.center,
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
                Expanded(
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
                rightWidget ?? SizedBox(width: 40.0.sp),
              ],
            ),
          ),
          extendWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

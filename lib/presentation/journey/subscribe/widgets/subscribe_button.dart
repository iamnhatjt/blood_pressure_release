import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscribeButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final double? height;

  const SubscribeButton(
      {super.key, this.onPressed, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      width: double.infinity,
      height: height ?? 60.sp,
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
      onPressed: onPressed,
      child: child,
      backgroundColor: AppColor.green,
    );
  }
}

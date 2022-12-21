import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloodHeaderWidget extends StatelessWidget {
  final String title;
  final Color background;
  final Widget extendWidget;

  const BloodHeaderWidget({super.key, required this.title, required this.background, required this.extendWidget});
  @override
  Widget build(BuildContext context) {
    return AppHeader(
      title: title,
      decoration: BoxDecoration(
        color: background,
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000),
            offset: Offset(0, 4.0.sp),
            blurRadius: 4.0.sp,
          ),
        ],
      ),
      titleStyle: const TextStyle(color: AppColor.white),
      leftWidget: const BackButton(
        color: AppColor.white,
      ),
      rightWidget: ExportButton(
        titleColor: background,
      ),
      extendWidget: extendWidget,
    );
  }

}
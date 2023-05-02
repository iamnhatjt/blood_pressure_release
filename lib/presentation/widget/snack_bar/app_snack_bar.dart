import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flash.dart';

void showTopSnackBar(BuildContext context,
    {SnackBarType type = SnackBarType.warning, required String message}) {
  showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          barrierDismissible: true,
          behavior: FlashBehavior.floating,
          position: FlashPosition.top,
          child: AppSnackBarWidget(
            type: type,
            message: message,
          ),
        );
      });
}

class AppSnackBarWidget extends StatelessWidget {
  final SnackBarType type;
  final String message;

  const AppSnackBarWidget({
    Key? key,
    this.type = SnackBarType.warning,
    required this.message,
  }) : super(key: key);

  String get iconPath {
    switch (type) {
      case SnackBarType.done:
        return AppImage.icDone;
      case SnackBarType.error:
        return AppImage.icCircleClose;
      default:
        return AppImage.icWarning;
    }
  }

  Color? get backgroundColor {
    switch (type) {
      case SnackBarType.done:
        return AppColor.green50;
      case SnackBarType.error:
        return AppColor.red50;
      default:
        return AppColor.orange50;
    }
  }

  Color? get textColor {
    switch (type) {
      case SnackBarType.done:
        return AppColor.green;
      case SnackBarType.error:
        return AppColor.red;
      default:
        return AppColor.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(12)),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: backgroundColor!,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ]),
      padding: EdgeInsets.all(12.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImageWidget.asset(
            path: iconPath,
            width: 20.sp,
            height: 20.sp,
            color: textColor,
          ),
          SizedBox(
            width: 20.sp,
          ),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: textColor),
            ),
          )
        ],
      ),
    );
  }
}

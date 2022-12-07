import 'package:bloodpressure/app/res/image/app_image.dart';
import 'package:bloodpressure/app/ui/widget/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';
import 'app_style.dart';
import 'app_touchable.dart';

class AppDialogHeartRateWidget extends StatelessWidget {
  const AppDialogHeartRateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthBar = Get.width / 4.1 * 3;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0.sp, horizontal: 12.0.sp),
          child: Row(
            children: [
              Text('Dec 29, 2022', style: textStyle18500()),
              const Spacer(),
              Text('10:12 PM', style: textStyle18500()),
            ],
          ),
        ),
        SizedBox(height: 18.0.sp),
        Text(
          '70',
          style: TextStyle(
            fontSize: 80.0.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.green,
            height: 5 / 4,
          ),
        ),
        SizedBox(height: 4.0.sp),
        Text(
          'BPM',
          style: TextStyle(
            fontSize: 30.0.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
            height: 37.5 / 30,
          ),
        ),
        SizedBox(height: 20.0.sp),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 8.0.sp),
          decoration: BoxDecoration(
            color: AppColor.green,
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
          child: Text(
            'Normal',
            style: textStyle20500().merge(const TextStyle(color: AppColor.white)),
          ),
        ),
        SizedBox(height: 32.0.sp),
        AppTouchable(
          onPressed: () {},
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
          margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
          outlinedBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0.sp),
          ),
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(9.0.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Resting Heart Rate 60-100',
                style: textStyle16400(),
              ),
              SizedBox(width: 4.0.sp),
              Icon(Icons.info_outline, size: 18.0.sp, color: AppColor.black),
            ],
          ),
        ),
        SizedBox(height: 12.0.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Text(
            'Oh! your heart rate is higher than normal. If happens 3 or more times, you’d better see your doctor for some presciptions',
            textAlign: TextAlign.center,
            style: textStyle14400().merge(const TextStyle(color: AppColor.black, height: 17.5 / 14)),
          ),
        ),
        SizedBox(height: 24.0.sp),
        SizedBox(
          width: widthBar + 20.0.sp,
          child: Row(
            children: [
              SizedBox(width: widthBar / 2),
              AppImageWidget.asset(path: AppImage.ic_down, width: 20.0.sp),
            ],
          ),
        ),
        SizedBox(height: 2.0.sp),
        SizedBox(
          width: widthBar,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.violet,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
              SizedBox(width: 4.0.sp),
              Expanded(
                flex: 2,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
              SizedBox(width: 4.0.sp),
              Expanded(
                flex: 3,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.red,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTouchable(
              onPressed: () {},
              padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
              child: Text(
                'Age : 30',
                style: textStyle18400().merge(const TextStyle(
                  shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.grayText2,
                )),
              ),
            ),
            SizedBox(width: 12.0.sp),
            AppTouchable(
              onPressed: () {},
              padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
              child: Text(
                'Male',
                style: textStyle18400().merge(const TextStyle(
                  shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.grayText2,
                )),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0.sp),
      ],
    );
  }
}

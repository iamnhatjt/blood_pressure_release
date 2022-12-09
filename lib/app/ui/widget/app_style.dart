import 'package:bloodpressure/app/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle textStyle24700() {
  return TextStyle(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.white,
    height: 30 / 24,
  );
}

TextStyle textStyle22700() {
  return TextStyle(
    fontSize: 22.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
    height: 27.5 / 22,
  );
}

TextStyle textStyle20700() {
  return TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.white,
    height: 25 / 20,
  );
}

TextStyle textStyle20500() {
  return TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
    height: 25 / 20,
  );
}

TextStyle textStyle20400() {
  return TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
    height: 24 / 20,
  );
}

TextStyle textStyle18700() {
  return TextStyle(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
    height: 22.5 / 18,
  );
}

TextStyle textStyle18500() {
  return TextStyle(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
    height: 22.5 / 18,
  );
}

TextStyle textStyle18400() {
  return TextStyle(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
    height: 20 / 18,
  );
}

TextStyle textStyle16400() {
  return TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
    height: 24 / 16,
  );
}

TextStyle textStyle14400() {
  return TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF9F9F9F),
    height: 20 / 14,
  );
}

TextStyle textStyle14500() {
  return TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
    height: 17.5 / 14,
  );
}

BoxDecoration commonDecoration() {
  return BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(10.0.sp),
    boxShadow: [
      BoxShadow(
        color: const Color(0x40000000),
        offset: const Offset(0, 0),
        blurRadius: 10.0.sp,
      ),
    ],
  );
}

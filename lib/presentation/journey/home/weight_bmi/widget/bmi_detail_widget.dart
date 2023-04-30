import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/enum/bmi_type.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../theme/app_color.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_touchable.dart';

class BMIDetailWidget extends StatelessWidget {
  final String date;
  final String time;
  final int bmi;
  final int weight;
  final int height;
  final BMIType bmiType;
  final Function() onEdit;
  final Function() onDelete;

  const BMIDetailWidget(
      {Key? key,
      required this.date,
      required this.time,
      required this.bmi,
      required this.weight,
      required this.height,
      required this.bmiType,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: onEdit,
      child: ButtonIos3D.onlyInner(
        backgroundColor: Colors.white,
        innerColor: const Color(0xFF89C7FF),
        radius: 16,
        offsetInner: const Offset(0, 0),
        child: Row(
          children: [
            SizedBox(width: 16.0.sp),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 12.0.sp,
                      ),
                      Text(
                        date,
                        style: textStyle14500()
                            .copyWith(color: const Color(0xFF646464)),
                      ),
                      Text(
                        time,
                        style: textStyle14500()
                            .copyWith(color: const Color(0xFF646464)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0.sp,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${TranslationConstants.bmi.tr}: $bmi',
                        style: textStyle18700()
                            .copyWith(color: const Color(0xFF646464)),
                      ),
                      SizedBox(
                        height: 12.0.sp,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  SizedBox(
                    height: 12.0.sp,
                  ),
                  RichText(
                    text: TextSpan(
                        text: '$weight',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                          color: Color(0xFF606060),
                        ),
                        children: [
                          TextSpan(
                            text: ' Kg',
                            style: textStyle14500()
                                .copyWith(color: const Color(0xFF606060)),
                          )
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: '$height',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                          color: Color(0xFF606060),
                        ),
                        children: [
                          TextSpan(
                            text: ' Cm',
                            style: textStyle14500()
                                .copyWith(color: const Color(0xFF606060)),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 12.0.sp,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: bmiType.colorText,
                  ),
                  Expanded(
                    child: Container(
                      width: 60.0.sp,
                      child: Text(
                        bmiType.bmiName,
                        style: const TextStyle(
                            overflow: TextOverflow.visible,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF646464)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onDelete,
                      child: const Icon(
                    CupertinoIcons.delete_solid,
                    color: Color(0xFFFF7070),
                  )),
                  SizedBox(width: 16.0.sp),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

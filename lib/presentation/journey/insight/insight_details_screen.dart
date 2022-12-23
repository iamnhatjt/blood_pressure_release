import 'package:bloodpressure/common/util/disable_%20glow_behavior.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InsightDetails extends StatelessWidget {
  const InsightDetails({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.contents,
  }) : super(key: key);

  final String title;
  final List<String> contents;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        child: Column(
      children: [
        AppHeader(
          leftWidget: AppTouchable.common(
            onPressed: () => Get.back(),
            decoration: const BoxDecoration(boxShadow: null),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColor.black,
              size: 40.0.sp,
            ),
          ),
          title: title,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(32.0.sp).copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppImageWidget.asset(
                      path: iconPath,
                      height: 100.0.sp,
                    ),
                    SizedBox(height: 30.0.sp,),
                    ...contents.map(
                      (e) => Text(
                        "   $e\n",
                        style: textStyle16400(),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}

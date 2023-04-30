import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  const FilterWidget(
      {super.key,
      required this.onPressed,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return ButtonIos3D.WhiteButtonUsal(
      radius: 10,
      height: 40.0.sp,
      width: Get.width,
        onPress: onPressed,
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Center(
                child: Text(
                  title,
                  style: textStyle16400().copyWith(color: const Color(0xFF7A7A7A)),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

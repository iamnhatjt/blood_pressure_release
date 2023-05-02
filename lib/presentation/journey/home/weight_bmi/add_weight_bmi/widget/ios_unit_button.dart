import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../common/constants/app_image.dart';
import '../../../../../theme/theme_text.dart';
import '../../../../../widget/app_image_widget.dart';
import '../../../../../widget/ios_cofig_widget/Button_ios_3d.dart';

class IosUnitButton extends StatelessWidget {
  final double? width;
  final Function()? onPressed;
  final String value;

  const IosUnitButton({Key? key, this.width, this.onPressed, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonIos3D(
      // shadowColor: Color(0xFF89C7FF),
      innerColor: Colors.black.withOpacity(0.15),
      innerRadius: 4,
      offsetInner: const Offset(0, -2),
      dropColor: Colors.black.withOpacity(0.25),
      offsetDrop: const Offset(0, 1),
      radius: 10,
      width: width,
      onPress: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  value,
                  style: textStyle16500()
                      .copyWith(color: const Color(0xFF646464)),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImageWidget.asset(
                  path: AppImage.iosUpAge,
                  height: 10.sp,
                ),
                SizedBox(height: 2.0.sp,),
                AppImageWidget.asset(
                  path: AppImage.iosDownAge,
                  height: 10.sp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/app_touchable.dart';

class SubscribeButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final double? height;

  const SubscribeButton(
      {super.key, this.onPressed, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return ButtonIos3D(
          radius: 10,
            innerColor: const Color(0xFF000000).withOpacity(0.15),
            offsetInner: Offset(0, -4),
            innerRadius: 10,
          backgroundColor: const Color(0xFF45BCFF),
          dropColor: const Color(0xFF45BCFF).withOpacity(0.6),
          offsetDrop: Offset(0, 4),
          dropRadius: 10,
      width: double.infinity,
      height: height ?? 60.sp,
      onPress: onPressed,
      child: child,
      // backgroundColor: const Color(0xFF45BCFF),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonIos3D extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? backgroundColor;
  final Color? innerColor;
  final Color? dropColor;
  final Offset? offsetInner;
  final Offset? offsetDrop;
  final double? innerRadius;
  final double? dropRadius;
  final Function()? onPress;
  final Widget child;

  const ButtonIos3D(
      {Key? key,
      this.height,
      this.width,
      this.radius,
      this.backgroundColor,
      this.innerColor,
      this.dropColor,
      this.offsetInner,
      this.offsetDrop,
      this.innerRadius,
      this.dropRadius,
      this.onPress,
      required this.child})
      : super(key: key);

  const ButtonIos3D.WhiteButtonUsal({super.key,
    this.height,
    this.width,
    this.radius = 20,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.innerColor,
    this.dropColor,
    this.offsetInner,
    this.offsetDrop,
    this.innerRadius,
    this.dropRadius,
    this.onPress,
    required this.child,
  });

  const ButtonIos3D.onlyInner({super.key,
    this.height,
    this.width,
    this.radius = 20,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.innerColor,
    this.dropColor =Colors.transparent,
    this.offsetInner,
    this.offsetDrop,
    this.innerRadius,
    this.dropRadius,
    this.onPress,
    required this.child,
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 20),
            boxShadow: [
              BoxShadow(
                offset: offsetDrop ?? const Offset(0, 1),
                blurRadius: dropRadius ?? 4.0,
                color: dropColor ?? Colors.black.withOpacity(0.25),
              )
            ]),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 20),

        ),
          child: InnerShadow(
            shadows: [
              Shadow(
                color: innerColor ?? Colors.black.withOpacity(0.15),
                offset: offsetInner ?? const Offset(0, -2),
                blurRadius: innerRadius ?? 4.0,
              ),
            ],
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 20),
                color: backgroundColor ?? Colors.white,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

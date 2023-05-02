import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class AppWeekdaysPicker extends StatelessWidget {
//   AppWeekdaysPicker({
//     Key? key,
//
//     /// must have length of 7
//     List<bool>? initialWeekDays,
//
//     /// will be ignored when @enableSelection is false
//     /// and must be provided when @enableSelection is true
//     this.onSelectedWeekdaysChanged,
//     this.enableSelection = false,
//   })  : assert(enableSelection == false || initialWeekDays!.length == 7),
//         initialWeekDays = initialWeekDays ?? List<bool>.generate(7, (_) => false),
//         super(key: key);
//
//   final bool? enableSelection;
//   final List<bool> initialWeekDays;
//   final void Function(List<bool>)? onSelectedWeekdaysChanged;
//
//   static const weekDayNames = ["M", "T", "W", "T", "F", "S", "S"];
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 302.sp,
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         for (int index = 0; index < weekDayNames.length; index++)
//           AppTouchable(
//             padding: EdgeInsets.symmetric(horizontal: 8.sp),
//             rippleColor: AppColor.whiteBG,
//             onPressed:
//                 enableSelection == true ? () {
//                   _onPressed(index);
//                 } : null,
//             child: Column(
//               children: [
//                 Text(
//                   weekDayNames[index],
//                   style: textStyle20700().copyWith(
//                     color: AppColor.black,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 8.sp,
//                 ),
//                 Icon(
//                   initialWeekDays[index]
//                       ? Icons.check_circle_rounded
//                       : Icons.circle_rounded,
//                   size: 20.sp,
//                   color: initialWeekDays[index]
//                       ? AppColor.primaryColor
//                       : AppColor.gray,
//                 ),
//               ],
//             ),
//           )
//       ]),
//     );
//   }
//
//   void _onPressed(index) {
//     final changedWeekDays = [...initialWeekDays];
//     changedWeekDays[index] = !changedWeekDays[index];
//     if (onSelectedWeekdaysChanged != null) onSelectedWeekdaysChanged!(changedWeekDays);
//   }
//
// }



class AppWeekdaysPicker extends StatelessWidget {
  AppWeekdaysPicker({
    Key? key,

    /// must have length of 7
    List<bool>? initialWeekDays,

    /// will be ignored when @enableSelection is false
    /// and must be provided when @enableSelection is true
    this.onSelectedWeekdaysChanged,
    this.enableSelection = false,
  })  : assert(enableSelection == false || initialWeekDays!.length == 7),
        initialWeekDays =
            initialWeekDays ?? List<bool>.generate(7, (_) => false),
        super(key: key);

  final bool? enableSelection;
  final List<bool> initialWeekDays;
  final void Function(List<bool>)? onSelectedWeekdaysChanged;

  static const weekDayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 302.sp,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          for (int index = 0; index < weekDayNames.length; index++)
            ButtonIos3D(
              innerColor: initialWeekDays[index] ? const Color(0xFF40A4FF).withOpacity(0.2) : Colors.black.withOpacity(0.15) ,
              dropColor: initialWeekDays[index] ? const Color(0xFF40A4FF).withOpacity(0.5) : Colors.black.withOpacity(0.25) ,
              radius: 9,
              height: 48.0.sp,
              width: 36.0.sp,
              innerRadius: 3,
              dropRadius: 6,
              offsetInner: const Offset(0,-3),
              offsetDrop: const Offset(0,2),
              // padding: EdgeInsets.symmetric(horizontal: 8.sp),
              backgroundColor:initialWeekDays[index]? const Color(0xFF40A4FF): Colors.white,

              onPress: enableSelection == true
                  ? () {
                _onPressed(index);
              }
                  : null,
              child: Center(
                child: Text(
                  weekDayNames[index],
                  style: textStyle20700().copyWith(
                      color:initialWeekDays[index] ? Colors.white: const Color(0xFF7A7A7A),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0.sp),
                ),
              ),
            )
        ]));
  }



  void _onPressed(index) {
    final changedWeekDays = [...initialWeekDays];
    changedWeekDays[index] = !changedWeekDays[index];
    if (onSelectedWeekdaysChanged != null)
      onSelectedWeekdaysChanged!(changedWeekDays);
  }
}

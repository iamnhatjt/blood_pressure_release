import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        initialWeekDays = initialWeekDays ?? List<bool>.generate(7, (_) => false),
        super(key: key);

  final bool? enableSelection;
  final List<bool> initialWeekDays;
  final void Function(List<bool>)? onSelectedWeekdaysChanged;

  static const weekDayNames = ["M", "T", "W", "T", "F", "S", "S"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 302.sp,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        for (int index = 0; index < weekDayNames.length; index++)
          AppTouchable(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            rippleColor: AppColor.whiteBG,
            onPressed:
                enableSelection == true ? () {
                  _onPressed(index);
                } : null,
            child: Column(
              children: [
                Text(
                  weekDayNames[index],
                  style: textStyle20700().copyWith(
                    color: AppColor.black,
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Icon(
                  initialWeekDays[index]
                      ? Icons.check_circle_rounded
                      : Icons.circle_rounded,
                  size: 20.sp,
                  color: initialWeekDays[index]
                      ? AppColor.primaryColor
                      : AppColor.gray,
                ),
              ],
            ),
          )
      ]),
    );
  }

  void _onPressed(index) {
    final changedWeekDays = [...initialWeekDays];
    changedWeekDays[index] = !changedWeekDays[index];
    if (onSelectedWeekdaysChanged != null) onSelectedWeekdaysChanged!(changedWeekDays);
  }

}

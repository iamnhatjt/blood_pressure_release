import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/disable_glow_behavior.dart';
import '../../common/util/translation/app_translation.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_button.dart';
import 'ios_cofig_widget/Button_ios_3d.dart';

class AppDialogAgeWidget extends StatefulWidget {
  final int? initialAge;
  final Function()? onPressCancel;
  final Function(int value)? onPressSave;

  const AppDialogAgeWidget(
      {Key? key, this.initialAge, this.onPressCancel, this.onPressSave})
      : super(key: key);

  @override
  State<AppDialogAgeWidget> createState() => _AppDialogAgeWidgetState();
}

class _AppDialogAgeWidgetState extends State<AppDialogAgeWidget> {
  late FixedExtentScrollController fixedExtentScrollController;
  late int _value;

  @override
  void initState() {
    fixedExtentScrollController =
        FixedExtentScrollController(initialItem: (widget.initialAge ?? 30) - 2);
    _value = widget.initialAge ?? 30;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0.sp,
          height: 180.0.sp,
          margin: EdgeInsets.symmetric(vertical: 24.0.sp),
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: CupertinoPicker.builder(
              scrollController: fixedExtentScrollController,
              childCount: 109,
              itemExtent: 60.0.sp,
              onSelectedItemChanged: (value) {
                _value = value + 2;
              },
              selectionOverlay: Container(
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color: const Color(0xFFCACACA), width: 2.0.sp))),
              ),
              itemBuilder: (context, value) {
                return Center(
                  child: Text(
                    '${value + 2}',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 40.0.sp,
                      fontWeight: FontWeight.w700,
                      height: 5 / 4,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ButtonIos3D(
                onPress: widget.onPressCancel,
                height: 60.0.sp,
                width: Get.width,
                backgroundColor: const Color(0xFFFF6464),
                radius: 20.0.sp,
                dropRadius: 10,
                offsetDrop: Offset.zero,
                dropColor: Colors.black.withOpacity(0.25),
                innerColor: Colors.black.withOpacity(0.25),
                innerRadius: 4,
                offsetInner: const Offset(0,-4),
                child: Center(
                  child: Text(
                    TranslationConstants.cancel.tr,
                    textAlign: TextAlign.center,
                    style: textStyle24700(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: ButtonIos3D(

                onPress: () => widget.onPressSave!(_value),
                height: 60.0.sp,
                width: Get.width,
                // text: firstButtonText,
                backgroundColor: const Color(0xFF5298EB),
                dropRadius: 10,
                offsetDrop: Offset.zero,
                dropColor: Colors.black.withOpacity(0.25),
                innerColor: Colors.black.withOpacity(0.25),
                innerRadius: 4,
                offsetInner: const Offset(0,-4),
                radius: 20.0.sp,
                child: Center(
                  child: Text(
                    TranslationConstants.save.tr,
                    textAlign: TextAlign.center,
                    style: textStyle24700(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

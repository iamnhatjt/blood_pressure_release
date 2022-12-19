import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onChanged;

  const BloodTextFieldWidget({super.key, this.controller, this.onChanged});
  @override
  State<StatefulWidget> createState() => _BloodTextFieldWidgetState();

}

class _BloodTextFieldWidgetState extends State<BloodTextFieldWidget> {
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if (focus.hasFocus == false) {
        if (widget.onChanged != null) {
          widget.onChanged!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.lightGray,
      borderRadius: BorderRadius.circular(9.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.sp),
        child: Center(
          child: TextFormField(
            focusNode: focus,
            controller: widget.controller,
            cursorColor: AppColor.primaryColor,
            textAlign: TextAlign.center,
            maxLines: null,
            expands: true,
            style: ThemeText.headline4
                .copyWith(fontSize: 30.sp, fontWeight: FontWeight.w600),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {},
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.lightGray,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}

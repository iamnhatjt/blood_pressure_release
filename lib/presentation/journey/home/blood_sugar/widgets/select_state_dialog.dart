import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'filter_state_widget.dart';

class SelectStateDialog extends StatelessWidget {
  final RxString rxSelectedState;
  final Function(String) onSelected;

  const SelectStateDialog(
      {super.key, required this.rxSelectedState, required this.onSelected});

  Widget _buildItemWidget(String stateCode, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(left: 24.sp, bottom: 16.sp),

      child: ButtonIos3D.WhiteButtonUsal(
        radius: 10,
          onPress: () => onSelected(stateCode),

          backgroundColor: isSelected
              ? const Color(0xFF40A4FF)
              : AppColor.white,
          child: Container(

            padding: EdgeInsets.all(8.sp),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FilterStateWidget.getState(stateCode),
                  style: IosTextStyle.f16w500wb.copyWith(color: isSelected ? Colors.white: const Color(0xFF646464)),
                  // style: ThemeText.headline6.copyWith(fontWeight: FontWeight.w500),
                ),
                AppImageWidget.asset(path: isSelected ?AppImage.iosIcSelect: AppImage.iosNotIcSelect, height: 20.0.sp, )
                // AppImage()
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.sp,
        ),
        Column(
          children: bloodSugarStateCodeList
              .map((e) =>
                  Obx(() => _buildItemWidget(e, rxSelectedState.value == e)))
              .toList(),
        ),
        SizedBox(
          height: 76.sp,
        ),
      ],
    );
  }
}

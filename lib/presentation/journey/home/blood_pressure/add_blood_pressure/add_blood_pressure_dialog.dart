import 'dart:io';

import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/extensions/string_extension.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/enum/blood_pressure_type.dart';
import 'package:bloodpressure/domain/model/blood_pressure_model.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/add_blood_pressure/add_blood_pressure_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/add_blood_pressure/widget/scroll_blood_pressure_value_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_loading.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../../common/constants/app_route.dart';
import '../../../../../common/util/app_util.dart';
import '../../../../controller/app_controller.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_touchable.dart';

class AddBloodPressureDialog extends GetView<AddBloodPressureController> {
  final BloodPressureModel? bloodPressureModel;

  const AddBloodPressureDialog({
    super.key,
    this.bloodPressureModel,
  });

  void _onAddData() {
    bloodPressureModel != null ? controller.onSave() : controller.addBloodPressure();
  }

  @override
  Widget build(BuildContext context) {

    Widget showInfor(
        String text, Function(int value)? onSelect, int intiValue) {
      return Stack(
        children: [
          ButtonIos3D.onlyInner(
            width: double.maxFinite,
            height: 120.0.sp,
            innerColor: const Color(0xFF89C7FF),
            radius: 16.0.sp,
            child: Column(
              children: [
                SizedBox(
                  height: 10.0.sp,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF646464)),
                ),
                
                SizedBox(
                  height: 10.0.sp,
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 120.0.sp,
            child: Container(
              margin: EdgeInsets.only(top: 40.0.sp),
              child: AddInforIntoDialog(
                onChanged: onSelect,
                initValue: intiValue,
              ),
            ),
          )
        ],
      );
    }

    controller.context = context;
    if (bloodPressureModel != null) {
      controller.onEdit(bloodPressureModel!);
    }
    return AppDialog(
      firstButtonText: bloodPressureModel != null ? TranslationConstants.save.tr : TranslationConstants.add.tr,
      firstButtonCallback: () => _onAddData(),
      secondButtonText: TranslationConstants.cancel.tr,
      secondButtonCallback: () => Get.back(),
      coverScreenWidget: Obx(() => controller.isLoading.value ? const AppLoading() : const SizedBox()),
      widgetBody: Padding(

        padding:  EdgeInsets.all(8.0.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ButtonIos3D.WhiteButtonUsal(
                  radius: 10,
                    onPress: controller.onSelectBloodPressureDate,
                    child: Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),

                        child: Text(
                          controller.stringBloodPrDate.value,
                          style: textStyle16500().copyWith(color: const Color(0xFF646464)),
                        ),
                      ),
                    )),
                const Spacer(),
                ButtonIos3D.WhiteButtonUsal(
                    radius: 10,
                    onPress: controller.onSelectBloodPressureDate,
                    child: Obx(
                          () => Container(
                        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),

                        child: Text(
                          controller.stringBloodPrTime.value,
                          style: textStyle16500().copyWith(color: const Color(0xFF646464)),
                        ),
                      ),
                    )),

              ],
            ),


            SizedBox(
              height: 42.sp,
            ),


            Container(
              padding: EdgeInsets.only(
                  bottom: 9.0.sp, top: 3.0.sp, right: 3.0.sp, left: 3.0.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0.sp),
                  color: Color(0xFFF4FAFF)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                            () => Expanded(
                            child: showInfor(
                                TranslationConstants.systolic.tr,
                                    (value) => controller.onSelectSys(value),
                                controller.systolic.value)),
                      ),
                      SizedBox(
                        width: 4.0.sp,
                      ),
                      Obx(
                            () => Expanded(
                            child: showInfor(
                                TranslationConstants.diastolic.tr,
                                    (value) => controller.onSelectDia(value),
                                controller.diastolic.value)),
                      ),
                      SizedBox(
                        width: 4.0.sp,
                      ),
                      Obx(
                            () => Expanded(
                          child: showInfor(
                              TranslationConstants.pulse.tr,
                                  (value) => controller.onSelectPules(value),
                              controller.pulse.value),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 21.sp,
                  ),
                  Obx(
                        () => ButtonIos3D.onlyInner(
                          backgroundColor:  controller.bloodPressureType.value.color ,
                          radius: 10,
                          onPress: controller.onShowBloodPressureInfo,
                          width: double.maxFinite,
                          innerColor: const Color(0xFF000000).withOpacity(0.15),
                          offsetInner: Offset.zero,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 12.0.sp),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                controller.bloodPressureType.value.name,
                                style: textStyle20600().copyWith(
                                    color:
                                    controller.bloodPressureType.value.colorText),
                              ),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),


            SizedBox(
              height: 16.sp,
            ),


            ButtonIos3D.WhiteButtonUsal(
              onPress: controller.onShowBloodPressureInfo,
              width:252.0.sp,
              radius: 10,

              child: Container(
                padding: EdgeInsets.all(8.0.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                          child: Obx(
                        () => Text(
                          controller.bloodPressureType.value.sortMessageRange,
                          style: textStyle16400().copyWith(color: const Color(0xFF6C6C6C)),
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ),
                    SizedBox(width: 4.0.sp),
                    Icon(
                      Icons.info_outline,
                      size: 18.0.sp,
                      color: AppColor.black,
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(
              height: 20.sp,
            ),


            Obx(
              () => Container(
                width: 252.0.sp,
                child: Text(
                  controller.bloodPressureType.value.message,
                  style: textStyle12400().copyWith(color: const Color(0xFF6C6C6C)),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            SizedBox(
              height: 20.sp,
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTouchable(
                  onPressed: controller.onPressedAge,
                  padding:
                  EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
                  child: Obx(() => Text(
                    '${TranslationConstants.age.tr}: ${controller.age.value}',
                    style: textStyle18400().merge(const TextStyle(
                      shadows: [
                        Shadow(
                            color: AppColor.grayText2, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.grayText2,
                    )),
                  )),
                ),
                SizedBox(width: 12.0.sp),
                AppTouchable(
                  onPressed: controller.onPressGender,
                  padding:
                  EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
                  child: Obx(() {
                    return Text(
                      chooseContentByLanguage(controller.gender['nameEN'],
                          controller.gender['nameVN']),
                      style: textStyle18400().merge(const TextStyle(
                        shadows: [
                          Shadow(color: AppColor.grayText2, offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.grayText2,
                      )),
                    );
                  }),
                ),
              ],
            ),

            SizedBox(
              height: 50.sp,
            )
          ],
        ),
      ),
    );
  }
}


class AddInforIntoDialog extends StatefulWidget {
  final TextEditingController? controller;
  final Function(int value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int initValue;

  const AddInforIntoDialog(
      {super.key,
        this.controller,
        this.onChanged,
        this.inputFormatters,
        required this.initValue});

  @override
  State<StatefulWidget> createState() => _AddInforIntoDialogState();
}

class _AddInforIntoDialogState extends State<AddInforIntoDialog> {
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if (focus.hasFocus == false) {
        if (widget.onChanged != null) {
          widget.onChanged!(100);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      borderRadius: BorderRadius.circular(9.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.sp),
        child: Center(
          child: TextFormField(
            initialValue: widget.initValue.toString(),
            focusNode: focus,
            controller: widget.controller,
            cursorColor: Colors.blue,
            textAlign: TextAlign.center,
            maxLines: null,
            expands: true,
            inputFormatters: widget.inputFormatters,
            style: ThemeText.headline4.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF40A4FF)),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) => widget.onChanged!(value.toInt),
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.transparent,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}

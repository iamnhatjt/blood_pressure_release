import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/enum/bmi_type.dart';
import 'package:bloodpressure/domain/enum/height_unit.dart';
import 'package:bloodpressure/domain/enum/weight_unit.dart';
import 'package:bloodpressure/domain/model/bmi_model.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/add_weight_bmi/add_weight_bmi_controller.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/add_weight_bmi/widget/ios_unit_button.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/add_weight_bmi/widget/unit_button.dart';
import 'package:bloodpressure/presentation/journey/home/widget/add_data_widget.dart';
import 'package:bloodpressure/presentation/journey/home/widget/blood_text_field_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_loading.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../../common/util/app_util.dart';
import '../../../../../common/util/format_utils.dart';
import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_image_widget.dart';
//
// class AddWeightBMIDialog extends GetView<AddWeightBMIController> {
//   final BMIModel? bmiModel;
//
//   const AddWeightBMIDialog({
//     super.key,
//     this.bmiModel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     controller.context = context;
//     if (bmiModel != null) {
//       controller.onEdit(bmiModel!);
//     }
//     return AddDataDialog(
//       rxStrDate: controller.stringBloodPrDate,
//       rxStrTime: controller.stringBloodPrTime,
//       onSelectDate: controller.onSelectBMIDate,
//       isEdit: bmiModel != null,
//       hasScroll: true,
//       onSelectTime: controller.onSelectBMITime,
//       secondButtonOnPressed: () => Get.back(),
//       firstButtonOnPressed: bmiModel != null ? controller.onSave : controller.addBMI,
//       coverScreenWidget: Obx(() => controller.isLoading.value ? const AppLoading() : const SizedBox()),
//       child: Column(
//         children: [
//           SizedBox(height: 24.sp),
//
//
//
//
//
//
//
//
//           Row(
//             children: [
//               Expanded(
//                 child: Obx(
//                   () => UnitButton(
//                     value: '${TranslationConstants.weight.tr} '
//                         '(${controller.weightUnit.value.label})',
//                     onPressed: controller.onSelectWeightUnit,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16.sp),
//               Expanded(
//                 child: Obx(
//                   () => UnitButton(
//                     value: '${TranslationConstants.height.tr} '
//                         '(${controller.heightUnit.value.label})',
//                     onPressed: controller.onSelectHeightUnit,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.sp),
//           SizedBox(
//             height: 68.sp,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: BloodTextFieldWidget(
//                     controller: controller.weightController,
//                     onChanged: controller.caculateBMI,                  ),
//                 ),
//                 SizedBox(
//                   width: 16.sp,
//                 ),
//                 Expanded(
//                   child: Obx(() {
//                     if (controller.heightUnit.value == HeightUnit.cm) {
//                       return BloodTextFieldWidget(
//                         controller: controller.cmController,
//                         onChanged: controller.caculateBMI,
//                       );
//                     } else {
//                       return Row(
//                         children: [
//                           Expanded(
//                             child: BloodTextFieldWidget(
//                               controller: controller.ftController,
//                               onChanged: controller.caculateBMI,
//                               inputFormatters: [
//                                 FeetFormatter(),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 8.sp,
//                           ),
//                           Expanded(
//                             child: BloodTextFieldWidget(
//                               controller: controller.inchController,
//                               onChanged: controller.caculateBMI,
//                               inputFormatters: [
//                                 InchesFormatter(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   }),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 48.sp,
//           ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Obx(
//                 () => Container(
//                   width: double.maxFinite,
//                   decoration: BoxDecoration(
//                     color: controller.bmiType.value.color,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(8),
//                     ),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   child: Text(
//                     controller.bmiType.value.bmiName,
//                     style: textStyle20600().copyWith(
//                       color: AppColor.white,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 16.sp,
//               ),
//               Obx(
//                 () => AppTouchable(
//                   onPressed: controller.onShowInfo,
//                   width: double.maxFinite,
//                   decoration: const BoxDecoration(
//                     color: AppColor.lightGray,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(9),
//                     ),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   child: Text(
//                     controller.bmiType.value.message,
//                     style: textStyle16400().copyWith(
//                       color: AppColor.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 28.sp,
//           ),
//           Obx(
//             () => Row(
//               children: BMIType.values
//                   .map(
//                     (e) => Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 6.sp),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             controller.bmiType.value == e
//                                 ? AppImageWidget.asset(
//                                     path: AppImage.ic_down,
//                                     width: 20.0.sp,
//                                     height: 12.sp,
//                                     color: controller.bmiType.value.color,
//                                   )
//                                 : SizedBox(
//                                     height: 12.sp,
//                                   ),
//                             SizedBox(
//                               height: 4.sp,
//                             ),
//                             Container(
//                               height: 12.sp,
//                               decoration: BoxDecoration(
//                                 color: e.color,
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(8),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//           SizedBox(
//             height: 30.sp,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AppTouchable(
//                 onPressed: controller.onPressedAge,
//                 padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
//                 child: Obx(() => Text(
//                       '${TranslationConstants.age.tr}: ${controller.age.value}',
//                       style: textStyle18400().merge(const TextStyle(
//                         shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
//                         color: Colors.transparent,
//                         decoration: TextDecoration.underline,
//                         decorationColor: AppColor.grayText2,
//                       )),
//                     )),
//               ),
//               SizedBox(width: 12.0.sp),
//               AppTouchable(
//                 onPressed: controller.onPressGender,
//                 padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
//                 child: Obx(() {
//                   return Text(
//                     chooseContentByLanguage(controller.gender['nameEN'], controller.gender['nameVN']),
//                     style: textStyle18400().merge(const TextStyle(
//                       shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
//                       color: Colors.transparent,
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppColor.grayText2,
//                     )),
//                   );
//                 }),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 36.sp,
//           )
//         ],
//       ),
//     );
//   }
// }



class AddWeightBMIDialog extends GetView<AddWeightBMIController> {
  final BMIModel? bmiModel;

  const AddWeightBMIDialog({
    super.key,
    this.bmiModel,
  });

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    if (bmiModel != null) {
      controller.onEdit(bmiModel!);
    }

    return Center(
      child: SingleChildScrollView(
        child: AddDataDialog(
            rxStrDate: controller.stringBloodPrDate,
            rxStrTime: controller.stringBloodPrTime,
            onSelectDate: controller.onSelectBMIDate,
            isEdit: bmiModel != null,
            hasScroll: false,
            onSelectTime: controller.onSelectBMITime,
            secondButtonOnPressed: () => Get.back(),
            firstButtonOnPressed:
            bmiModel != null ? controller.onSave : controller.addBMI,
            coverScreenWidget: Obx(() => controller.isLoading.value
                ? const AppLoading()
                : const SizedBox()),
            child: Column(
              children: [
                SizedBox(
                  height: 40.0.sp,
                ),
                Container(
                  // height: 236.0.sp,
                  // width: 320.0.sp,
                  padding: EdgeInsets.all(8.0.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FAFF),
                    borderRadius: BorderRadius.circular(16.0.sp),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Stack(
                                children: [

                                  ButtonIos3D.onlyInner(
                                    backgroundColor: Colors.white,
                                    innerColor: const Color(0xFF89C7FF),
                                    radius: 16,
                                    offsetInner: const Offset(0, 0),
                                    height: 128.0.sp,
                                    width: 150.0.sp,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10.0.sp),
                                          child: Obx(
                                                () => IosUnitButton(
                                              value: '${TranslationConstants.weight.tr} '
                                                  '(${controller.weightUnit.value.label})',
                                              onPressed: controller.onSelectWeightUnit,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 128.0.sp,
                                    width: 150.0.sp,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 50.0.sp),
                                      child: BloodTextFieldWidget(
                                        controller: controller.weightController,
                                        onChanged: controller.caculateBMI,
                                      ),
                                    ),
                                  )
                                ],
                              ),),
                          SizedBox(
                            width: 5.0.sp,
                          ),
                          Expanded(
                            child: Stack(
                              children: [

                                ButtonIos3D.onlyInner(
                                  backgroundColor: Colors.white,
                                  innerColor: const Color(0xFF89C7FF),
                                  radius: 16,
                                  offsetInner: const Offset(0, 0),
                                  height: 128.0.sp,
                                  width: 150.0.sp,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10.0.sp),
                                        child: Obx(
                                              () => IosUnitButton(
                                                value: '${TranslationConstants.height.tr} '
                                                    '(${controller.heightUnit.value.label})',
                                                onPressed: controller.onSelectHeightUnit,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 128.0.sp,
                                  width: 150.0.sp,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50.0.sp),
                                    child: Obx((){
                                      if (controller.heightUnit.value ==
                                          HeightUnit.cm) {
                                        return BloodTextFieldWidget(
                                          controller: controller.cmController,
                                          onChanged: controller.caculateBMI,

                                        );

                                      }
                                      else {
                                        return Row(
                                          children: [
                                            const Spacer(),
                                            Expanded(
                                              child: BloodTextFieldWidget(
                                                controller: controller.ftController,
                                                onChanged: controller.caculateBMI,
                                                inputFormatters: [
                                                  FeetFormatter(),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0.sp,
                                            ),
                                            Expanded(
                                              child: BloodTextFieldWidget(
                                                controller:
                                                controller.inchController,
                                                onChanged: controller.caculateBMI,
                                                inputFormatters: [
                                                  InchesFormatter(),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        );
                                      }
                                    })
                                  ),
                                )
                              ],
                            ),),
                          //
                        ],
                      ),
                      SizedBox(
                        height: 16.0.sp,
                      ),
                      Container(
                          width: 312.0.sp,
                          child:
                          Obx(
                                () => ButtonIos3D.onlyInner(
                                  innerColor: Colors.black.withOpacity(0.15),
                                  backgroundColor: controller.bmiType.value.color,
                                  offsetInner: Offset.zero,
                                  radius: 10,
                              width: 300.0.sp,

                              child: Padding(
                                padding:  EdgeInsets.all(8.0.sp),
                                child: Column(
                                  children: [
                                    Text(controller.weightController.text,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 36.0.sp,
                                          color: controller.bmiType.value.colorText,
                                        ),
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 4.0.sp,
                                    ),
                                    Text(controller.bmiType.value.bmiName.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0.sp,
                                          color: controller.bmiType.value.colorText,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.0.sp,
                ),
                ButtonIos3D(
                  innerColor: Colors.black.withOpacity(0.15),
                  innerRadius: 4,
                  offsetInner: const Offset(0, -2),
                  dropColor: Colors.black.withOpacity(0.25),
                  offsetDrop: const Offset(0, 1),
                  onPress: () {
                    showAppDialog(
                        firstButtonText: '',
                        hideGroupButton: true,
                        context,
                        TranslationConstants.bmi.tr,
                        '',
                        widgetBody: Container(
                          // height: 500.0.sp,
                          width: 360.0.sp,
                          child: Padding(
                              padding: EdgeInsets.only(
                                top: 32.0.sp,
                                // bottom: 70.0.sp,
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 450.0.sp,
                                      child: ListView(
                                        children: BMIType.values
                                            .map((e) => Container(
                                          margin: EdgeInsets.only(
                                              bottom: 12.0.sp),
                                          height: 72.0.sp,
                                          width: 314.0.sp,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8.0.sp),
                                              color: e.color),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 9.0.sp,
                                              horizontal: 14.0.sp),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.bmiName,
                                                style: TextStyle(
                                                    fontSize: 20.0.sp,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: e.colorText),
                                              ),
                                              SizedBox(
                                                height: 6.0.sp,
                                              ),
                                              Text(
                                                e.message,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    color: e.colorText),
                                              )
                                            ],
                                          ),
                                        ))
                                            .toList(),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        height: 60.0.sp,
                                        width: 300.0.sp,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            color: const Color(0xFF5298EB),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.25),
                                                blurRadius: 10,
                                                offset: const Offset(0.0, 0.0),
                                              ),
                                              BoxShadow(
                                                color: const Color(0xFF00288F)
                                                    .withOpacity(0.25),
                                                blurRadius: 10,
                                                offset: const Offset(0.0, -4.0),
                                              ),
                                            ]),
                                        child: Center(
                                          child: Text(
                                            TranslationConstants.ok.tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                        ));
                  },
                  radius: 10,
                  height: 35.0.sp,
                  width: 252.0.sp,
                  child: Row(
                    children: [
                      Obx(() => Expanded(
                          child: Center(
                              child: Text(
                                controller.bmiType.value.message,
                                style: TextStyle(
                                    color: const Color(0xFF656565),
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )))),
                       Icon(CupertinoIcons.info_circle, color: Color(0xFF656565).withOpacity(0.8),),
                      SizedBox(width: 4.0.sp)
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0.sp,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTouchable(
                      onPressed: controller.onPressedAge,
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0.sp, horizontal: 12.0.sp),
                      child: Obx(() => Text(
                        '${TranslationConstants.age.tr}: ${controller.age.value}',
                        style: textStyle18400().merge(const TextStyle(
                          shadows: [
                            Shadow(
                                color: AppColor.grayText2,
                                offset: Offset(0, -5))
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
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0.sp, horizontal: 12.0.sp),
                      child: Obx(() {
                        return Text(
                          chooseContentByLanguage(controller.gender['nameEN'],
                              controller.gender['nameVN']),
                          style: textStyle18400().merge(const TextStyle(
                            shadows: [
                              Shadow(
                                  color: AppColor.grayText2,
                                  offset: Offset(0, -5))
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
                SizedBox(height: 30.0.sp),
              ],
            )),
      ),
    );
  }
}


class BloodTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const BloodTextFieldWidget(
      {super.key, this.controller, this.onChanged, this.inputFormatters});

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
      color: AppColor.transparent,
      borderRadius: BorderRadius.circular(9.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.sp),
        child: Center(
          child: TextFormField(
            focusNode: focus,
            controller: widget.controller,
            cursorColor: Colors.blue,
            textAlign: TextAlign.center,
            maxLines: null,
            expands: true,
            inputFormatters: widget.inputFormatters,
            style: ThemeText.headline4.copyWith(
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF40A4FF)),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) => widget.onChanged,
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

import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/model/user_model.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/constants/app_constant.dart';
import '../../common/util/app_util.dart';
import '../../common/util/disable_glow_behavior.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_button.dart';
import 'app_dialog.dart';
import 'app_dialog_age_widget.dart';
import 'app_dialog_gender_widget.dart';
import 'app_image_widget.dart';
import 'app_touchable.dart';
import 'ios_cofig_widget/Button_ios_3d.dart';

class AppDialogHeartRateWidget extends StatefulWidget {
  final DateTime? inputDateTime;
  final int? inputValue;
  final Function()? onPressCancel;
  final Function(DateTime dateTime, int value)? onPressAdd;
  final bool? allowChange;

  const AppDialogHeartRateWidget(
      {Key? key,
      this.inputDateTime,
      this.inputValue,
      required this.onPressCancel,
      required this.onPressAdd,
      this.allowChange})
      : super(key: key);

  @override
  State<AppDialogHeartRateWidget> createState() =>
      _AppDialogHeartRateWidgetState();
}

class _AppDialogHeartRateWidgetState extends State<AppDialogHeartRateWidget> {
  DateTime? _dateTime;
  int? _value;
  String _date = '';
  String _time = '';
  String _restingHeartRateValue = '';
  String _restingHeartRateStatus = '';
  Color _restingHeartRateColor = AppColor.primaryColor;
  String _restingHeartRateMessage = '';
  final AppController _appController = Get.find<AppController>();
  late FixedExtentScrollController fixedExtentScrollController;

  @override
  void initState() {
    _dateTime = widget.inputDateTime;
    _value = (widget.inputValue ?? 0) < AppConstant.minHeartRate
        ? AppConstant.minHeartRate
        : (widget.inputValue ?? 0) > AppConstant.maxHeartRate
            ? AppConstant.maxHeartRate
            : widget.inputValue;
    _updateDateTimeString(widget.inputDateTime);
    _updateStatusByValue(widget.inputValue ?? 0);
    fixedExtentScrollController = FixedExtentScrollController(initialItem: 30);
    super.initState();
  }

  _updateDateTimeString(DateTime? dateTime) {
    if (dateTime != null) {
      setState(() {
        _date = DateFormat('MMM dd, yyyy').format(dateTime);
        _time = DateFormat('h:mm a').format(dateTime);
      });
    }
  }

  _updateStatusByValue(int value) {
    if ((_value ?? 0) < 60) {
      _restingHeartRateValue = '< 60';
      _restingHeartRateStatus = TranslationConstants.slow.tr;
      _restingHeartRateMessage = TranslationConstants.rhSlowMessage.tr;
      _restingHeartRateColor = const Color(0xFFCF71FB);
    } else if ((_value ?? 0) > 100) {
      _restingHeartRateValue = '> 100';
      _restingHeartRateStatus = TranslationConstants.fast.tr;
      _restingHeartRateMessage = TranslationConstants.rhFastMessage.tr;
      _restingHeartRateColor = const Color(0xFFFF6C6C);
    } else {
      _restingHeartRateValue = '60 - 100';
      _restingHeartRateStatus = TranslationConstants.normal.tr;
      _restingHeartRateMessage = TranslationConstants.rhNormalMessage.tr;
      _restingHeartRateColor = const Color(0xFF0B8C10);
    }
  }

  _onPressDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Get.find<AppController>().currentLocale,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
            colorScheme: const ColorScheme.light(
                onPrimary: AppColor.white, primary: AppColor.red)),
        child: child!,
      ),
    );
    if (result != null) {
      _dateTime = DateTime(result.year, result.month, result.day,
          _dateTime?.hour ?? 0, _dateTime?.minute ?? 0);
      _updateDateTimeString(_dateTime);
    }
  }

  _onPressTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: _dateTime?.hour ?? 0, minute: _dateTime?.minute ?? 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
            colorScheme: const ColorScheme.light(
                onPrimary: AppColor.white, primary: AppColor.red)),
        child: child!,
      ),
    );
    if (result != null) {
      _dateTime = DateTime(_dateTime?.year ?? 2000, _dateTime?.month ?? 1,
          _dateTime?.day ?? 1, result.hour, result.minute);
      _updateDateTimeString(_dateTime);
    }
  }

  _onPressAge() {
    int initialAge = _appController.currentUser.value.age ?? 30;
    initialAge = initialAge < 2
        ? 2
        : initialAge > 110
            ? 110
            : initialAge;
    showAppDialog(
      context,
      'Choose Your Age',
      '',
      hideGroupButton: true,
      widgetBody: AppDialogAgeWidget(
        initialAge: initialAge,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(UserModel(
              age: value,
              genderId: _appController.currentUser.value.genderId ?? '0'));
        },
      ),
    );
  }

  _onPressGender() {
    Map? initialGender = AppConstant.listGender.firstWhereOrNull((element) =>
        element['id'] == (_appController.currentUser.value.genderId ?? '0'));
    showAppDialog(
      context,
      'Choose your gender',
      '',
      hideGroupButton: true,
      widgetBody: AppDialogGenderWidget(
        initialGender: initialGender,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(UserModel(
              age: _appController.currentUser.value.age ?? 30,
              genderId: value['id'] ?? '0'));
        },
      ),
    );
  }

  _onPressHint() {
    showAppDialog(
      context,
      TranslationConstants.heartRate.tr,
      '',
      firstButtonText: 'Ok',
      widgetBody: Container(
        margin: EdgeInsets.symmetric(horizontal: 32.0.sp),
        child: Column(
          children: [
            SizedBox(height: 32.0.sp),
            ButtonIos3D.onlyInner(
              radius: 12,
              height: 52.0.sp,
              width: Get.width,
              innerRadius: 5,
              offsetInner: Offset(0, 0),
              innerColor: const Color(0xFFFFA6C1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.heart_solid,
                      color: const Color(0xFFFF6C6C),
                    ),
                    SizedBox(
                      width: 12.0.sp,
                    ),
                    Text(
                      TranslationConstants.fast.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF6C6C),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${TranslationConstants.heartRate.tr} > 100',
                      style: textStyle16400().merge(const TextStyle(
                          color: const Color(0xFFFF6C6C),
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.0.sp,
            ),
            ButtonIos3D.onlyInner(
              radius: 12,
              height: 52.0.sp,

              width: Get.width,
              innerRadius: 5,
              offsetInner: Offset(0, 0),
              innerColor: const Color(0xFF3AB600).withOpacity(0.5),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.heart_solid,
                      color: const Color(0xFF0B8C10),
                    ),
                    SizedBox(
                      width: 12.0.sp,
                    ),
                    Text(
                      TranslationConstants.normal.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B8C10),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${TranslationConstants.heartRate.tr} > 60',
                      style: textStyle16400().merge(const TextStyle(
                          color: Color(0xFF0B8C10),
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.0.sp,
            ),
            ButtonIos3D.onlyInner(
              radius: 12,
              height: 52.0.sp,

              width: Get.width,
              innerRadius: 5,
              offsetInner: Offset(0, 0),
              innerColor: const Color(0xFFCD00DF).withOpacity(0.31),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.heart_solid,
                      color: const Color(0xFFCF71FB),
                    ),
                    SizedBox(
                      width: 12.0.sp,
                    ),
                    Text(
                      TranslationConstants.slow.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFCF71FB),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${TranslationConstants.heartRate.tr} < 60',
                      style: textStyle16400().merge(const TextStyle(
                          color: const Color(0xFFCF71FB),
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 64.0.sp,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthBar = Get.width / 4.1 * 3;
    int range = AppConstant.maxHeartRate - AppConstant.minHeartRate;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0.sp, horizontal: 12.0.sp),
          child: Row(
            children: [
              ButtonIos3D(
                  innerColor: Colors.black.withOpacity(0.15),
                  innerRadius: 4,
                  offsetInner: const Offset(0, -2),
                  dropColor: Colors.black.withOpacity(0.25),
                  offsetDrop: const Offset(0, 1),
                  radius: 10,
                  onPress: widget.allowChange == true ? _onPressDate : null,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0.sp, horizontal: 26.0.sp),
                      child: Text(_date, style: IosTextStyle.f16w500wb))),
              const Spacer(),
              ButtonIos3D(
                  innerColor: Colors.black.withOpacity(0.15),
                  innerRadius: 4,
                  offsetInner: const Offset(0, -2),
                  dropColor: Colors.black.withOpacity(0.25),
                  offsetDrop: const Offset(0, 1),
                  radius: 10,
                  onPress: widget.allowChange == true ? _onPressTime : null,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0.sp, horizontal: 26.0.sp),
                      child: Text(_time, style: IosTextStyle.f16w500wb))),
            ],
          ),
        ),
        SizedBox(height: 52.0.sp),
        widget.allowChange == true
            ? SizedBox(
                // width: 100.0.sp,
                // height: 140.0.sp,
                child: ScrollConfiguration(
                  behavior: DisableGlowBehavior(),
                  child: ButtonIos3D.onlyInner(
                    height: 128.0.sp,
                    width: 260.0.sp,
                    innerColor: const Color(0xFF89C7FF),
                    radius: 16,
                    innerRadius: 5,
                    offsetInner: Offset.zero,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.0.sp,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 16.0.sp,
                            ),
                            ButtonIos3D(
                              onPress: () {
                                setState(() {
                                  if (_value != null) _value = _value! + 1;
                                  _updateStatusByValue(_value ?? 70);
                                });
                              },
                              innerColor:
                                  const Color(0xFF40A4FF).withOpacity(0.25),
                              dropColor:
                                  const Color(0xFF40A4FF).withOpacity(0.25),
                              innerRadius: 4,
                              dropRadius: 4,
                              offsetDrop: const Offset(0, -1),
                              offsetInner: const Offset(0, -2),
                              radius: 10,
                              child: Container(
                                padding: EdgeInsets.all(12.0.sp),
                                child: AppImageWidget.asset(
                                  path: AppImage.iosUpAge,
                                  height: 16.0.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0.sp,
                            ),
                            ButtonIos3D(
                              onPress: () {
                                setState(() {
                                  if (_value != null && _value! > 0)
                                    _value = _value! - 1;
                                  _updateStatusByValue(_value ?? 70);
                                });
                              },
                              radius: 10,
                              innerColor:
                                  const Color(0xFF40A4FF).withOpacity(0.25),
                              dropColor:
                                  const Color(0xFF40A4FF).withOpacity(0.25),
                              innerRadius: 4,
                              dropRadius: 4,
                              offsetDrop: const Offset(0, -1),
                              offsetInner: const Offset(0, -2),
                              child: Container(
                                padding: EdgeInsets.all(12.0.sp),
                                child: AppImageWidget.asset(
                                  path: AppImage.iosDownAge,
                                  height: 16.0.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0.sp,
                            ),
                          ],
                        ),
                        // const Spacer(),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_value',
                                style: TextStyle(
                                    color: _restingHeartRateColor,
                                    fontSize: 72,
                                    fontWeight: FontWeight.w700,
                                    height: 0.85),
                              ),
                              Text(
                                'BPM ',
                                style: TextStyle(
                                  fontSize: 22.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF656565),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 26.0.sp,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : InnerShadow(
                    shadows: [
                      BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, -6))
                    ],
                    child: Container(
                      margin: EdgeInsets.all(12.0.sp),

                      height: 220.0.sp,
                      width: 220.0.sp,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xFF000000).withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 0))
                          ]),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_value ?? 0}',
                              style: TextStyle(
                                fontSize: 80.0.sp,
                                fontWeight: FontWeight.w700,
                                color: _restingHeartRateColor,
                                height: 5 / 4,
                              ),
                            ),
                            SizedBox(height: 12.0.sp),
                            Text(
                              'BPM ',
                              style: TextStyle(
                                fontSize: 30.0.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF656565),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
        SizedBox(height: 20.0.sp),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 8.0.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.heart_solid,
                color: _restingHeartRateColor,
                size: 40,
              ),
              SizedBox(
                width: 12.0.sp,
              ),
              Text(
                _restingHeartRateStatus,
                style: textStyle16500()
                    .merge(const TextStyle(color: Color(0xFF656565))),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0.sp),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonIos3D(
              onPress: _onPressHint,
              innerColor: Colors.black.withOpacity(0.15),
              innerRadius: 4,
              offsetInner: const Offset(0, -2),
              dropColor: Colors.black.withOpacity(0.25),
              offsetDrop: const Offset(0, 1),
              radius: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0.sp),
                      child: Text(
                        '${TranslationConstants.restingHeartRate.tr} $_restingHeartRateValue',
                        style: IosTextStyle.f14w400wb,
                      ),
                    ),
                    SizedBox(width: 8.0.sp),
                    Icon(Icons.info_outline,
                        size: 18.0.sp, color: AppColor.black),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44.0.sp),
              child: Text(
                _restingHeartRateMessage,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0.sp,
                    color: const Color(0xFF6C6C6C)),
              ),
            ),
          ],
        ),
        SizedBox(height: 36.0.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTouchable(
              onPressed: () {
                _onPressAge();
              },
              padding:
                  EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
              child: Obx(() => Text(
                    '${TranslationConstants.age.tr}: ${_appController.currentUser.value.age ?? 30}',
                    style: textStyle18400().merge(const TextStyle(
                      shadows: [
                        Shadow(color: AppColor.grayText2, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.grayText2,
                    )),
                  )),
            ),
            SizedBox(width: 12.0.sp),
            AppTouchable(
              onPressed: () {
                _onPressGender();
              },
              padding:
                  EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
              child: Obx(() {
                Map gender = AppConstant.listGender.firstWhere(
                    (element) =>
                        element['id'] ==
                        _appController.currentUser.value.genderId,
                    orElse: () => AppConstant.listGender[0]);
                return Text(
                  chooseContentByLanguage(gender['nameEN'], gender['nameVN']),
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
        SizedBox(height: 16.0.sp),
        Row(
          children: [
            Expanded(
              child: ButtonIos3D(
                onPress: widget.onPressCancel,
                height: 60.0.sp,
                width: Get.width,
                // text: firstButtonText,
                backgroundColor: const Color(0xFFFF6464),
                dropRadius: 10,
                offsetDrop: Offset.zero,
                dropColor: Colors.black.withOpacity(0.25),
                innerColor: Colors.black.withOpacity(0.25),
                innerRadius: 4,
                offsetInner: const Offset(0, -4),
                radius: 20.0.sp,
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
                onPress: () => widget.onPressAdd!(
                    _dateTime ?? DateTime.now(), _value ?? 0),
                height: 60.0.sp,
                width: Get.width,
                // text: firstButtonText,
                backgroundColor: const Color(0xFF5298EB),
                dropRadius: 10,
                offsetDrop: Offset.zero,
                dropColor: Colors.black.withOpacity(0.25),
                innerColor: Colors.black.withOpacity(0.25),
                innerRadius: 4,
                offsetInner: const Offset(0, -4),
                radius: 20.0.sp,
                child: Center(
                  child: Text(
                    TranslationConstants.add.tr,
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

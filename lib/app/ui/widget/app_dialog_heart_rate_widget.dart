import 'package:bloodpressure/app/controller/app_controller.dart';
import 'package:bloodpressure/app/data/model/user_model.dart';
import 'package:bloodpressure/app/res/image/app_image.dart';
import 'package:bloodpressure/app/res/string/app_strings.dart';
import 'package:bloodpressure/app/ui/widget/app_dialog_gender_widget.dart';
import 'package:bloodpressure/app/ui/widget/app_image_widget.dart';
import 'package:bloodpressure/app/util/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../util/app_constant.dart';
import '../../util/disable_ glow_behavior.dart';
import '../theme/app_color.dart';
import 'app_button.dart';
import 'app_dialog.dart';
import 'app_dialog_age_widget.dart';
import 'app_style.dart';
import 'app_touchable.dart';

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
  State<AppDialogHeartRateWidget> createState() => _AppDialogHeartRateWidgetState();
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
        _date = formatWithLocale('MMM dd, yyyy', dateTime);
        _time = formatWithLocale('h:mm a', dateTime);
      });
    }
  }

  _updateStatusByValue(int value) {
    if ((_value ?? 0) < 60) {
      _restingHeartRateValue = '< 60';
      _restingHeartRateStatus = StringConstants.slow.tr;
      _restingHeartRateMessage = StringConstants.rhSlowMessage.tr;
      _restingHeartRateColor = AppColor.violet;
    } else if ((_value ?? 0) > 100) {
      _restingHeartRateValue = '> 100';
      _restingHeartRateStatus = StringConstants.fast.tr;
      _restingHeartRateMessage = StringConstants.rhFastMessage.tr;
      _restingHeartRateColor = AppColor.red;
    } else {
      _restingHeartRateValue = '60 - 100';
      _restingHeartRateStatus = StringConstants.normal.tr;
      _restingHeartRateMessage = StringConstants.rhNormalMessage.tr;
      _restingHeartRateColor = AppColor.green;
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
        data: ThemeData(colorScheme: const ColorScheme.light(onPrimary: AppColor.white, primary: AppColor.red)),
        child: child!,
      ),
    );
    if (result != null) {
      _dateTime = DateTime(result.year, result.month, result.day, _dateTime?.hour ?? 0, _dateTime?.minute ?? 0);
      _updateDateTimeString(_dateTime);
    }
  }

  _onPressTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _dateTime?.hour ?? 0, minute: _dateTime?.minute ?? 0),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(colorScheme: const ColorScheme.light(onPrimary: AppColor.white, primary: AppColor.red)),
        child: child!,
      ),
    );
    if (result != null) {
      _dateTime =
          DateTime(_dateTime?.year ?? 2000, _dateTime?.month ?? 1, _dateTime?.day ?? 1, result.hour, result.minute);
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
      StringConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogAgeWidget(
        initialAge: initialAge,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(UserModel(age: value, genderId: _appController.currentUser.value.genderId ?? '0'));
        },
      ),
    );
  }

  _onPressGender() {
    Map? initialGender = AppConstant.listGender
        .firstWhereOrNull((element) => element['id'] == (_appController.currentUser.value.genderId ?? '0'));
    showAppDialog(
      context,
      StringConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogGenderWidget(
        initialGender: initialGender,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController
              .updateUser(UserModel(age: _appController.currentUser.value.age ?? 30, genderId: value['id'] ?? '0'));
        },
      ),
    );
  }

  _onPressHint() {
    showAppDialog(
      context,
      StringConstants.heartRate.tr,
      '',
      firstButtonText: 'Ok',
      widgetBody: Column(
        children: [
          SizedBox(height: 8.0.sp),
          Container(
            height: 39.0.sp,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            margin: EdgeInsets.all(12.0.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.sp),
              color: AppColor.red,
            ),
            child: Row(
              children: [
                Text(
                  StringConstants.fast.tr,
                  style: textStyle20700(),
                ),
                const Spacer(),
                Text(
                  '${StringConstants.heartRate.tr} > 100',
                  style: textStyle16400().merge(const TextStyle(color: AppColor.white)),
                ),
              ],
            ),
          ),
          Container(
            height: 39.0.sp,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            margin: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 12.0.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.sp),
              color: AppColor.green,
            ),
            child: Row(
              children: [
                Text(
                  StringConstants.normal.tr,
                  style: textStyle20700(),
                ),
                const Spacer(),
                Text(
                  '${StringConstants.heartRate.tr} 60 - 100',
                  style: textStyle16400().merge(const TextStyle(color: AppColor.white)),
                ),
              ],
            ),
          ),
          Container(
            height: 39.0.sp,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
            margin: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 24.0.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.sp),
              color: AppColor.violet,
            ),
            child: Row(
              children: [
                Text(
                  StringConstants.slow.tr,
                  style: textStyle20700(),
                ),
                const Spacer(),
                Text(
                  '${StringConstants.heartRate.tr} < 60',
                  style: textStyle16400().merge(const TextStyle(color: AppColor.white)),
                ),
              ],
            ),
          ),
        ],
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
              AppTouchable(
                  onPressed: widget.allowChange == true ? _onPressDate : null,
                  child: Text(_date, style: textStyle18500())),
              const Spacer(),
              AppTouchable(
                  onPressed: widget.allowChange == true ? _onPressTime : null,
                  child: Text(_time, style: textStyle18500())),
            ],
          ),
        ),
        SizedBox(height: 18.0.sp),
        widget.allowChange == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 66.0.sp),
                  SizedBox(
                    width: 80.0.sp,
                    height: 140.0.sp,
                    child: ScrollConfiguration(
                      behavior: DisableGlowBehavior(),
                      child: CupertinoPicker.builder(
                        scrollController: fixedExtentScrollController,
                        childCount: 180,
                        itemExtent: 60.0.sp,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            _value = value + 40;
                          });
                          _updateStatusByValue(value + 40);
                        },
                        selectionOverlay: Container(
                          decoration: BoxDecoration(
                              border: Border.symmetric(
                                  horizontal: BorderSide(color: const Color(0xFFCACACA), width: 2.0.sp))),
                        ),
                        itemBuilder: (context, value) {
                          Color color = AppColor.primaryColor;
                          if (value + 40 < 60) {
                            color = AppColor.violet;
                          } else if (value + 40 > 100) {
                            color = AppColor.red;
                          } else {
                            color = AppColor.green;
                          }
                          return Center(
                            child: Text(
                              '${value + 40}',
                              style: TextStyle(
                                color: color,
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
                  Text(
                    'BPM',
                    style: TextStyle(
                      fontSize: 30.0.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                      height: 37.5 / 30,
                    ),
                  )
                ],
              )
            : Text(
                '${_value ?? 0}',
                style: TextStyle(
                  fontSize: 80.0.sp,
                  fontWeight: FontWeight.w700,
                  color: _restingHeartRateColor,
                  height: 5 / 4,
                ),
              ),
        widget.allowChange == true
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.only(top: 4.0.sp),
                child: Text(
                  'BPM',
                  style: TextStyle(
                    fontSize: 30.0.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                    height: 37.5 / 30,
                  ),
                ),
              ),
        SizedBox(height: 20.0.sp),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 8.0.sp),
          decoration: BoxDecoration(
            color: _restingHeartRateColor,
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
          child: Text(
            _restingHeartRateStatus,
            style: textStyle20500().merge(const TextStyle(color: AppColor.white)),
          ),
        ),
        SizedBox(height: 32.0.sp),
        AppTouchable(
          onPressed: _onPressHint,
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
          margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
          outlinedBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0.sp),
          ),
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(9.0.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${StringConstants.restingHeartRate.tr} $_restingHeartRateValue',
                style: textStyle16400(),
              ),
              SizedBox(width: 4.0.sp),
              Icon(Icons.info_outline, size: 18.0.sp, color: AppColor.black),
            ],
          ),
        ),
        SizedBox(height: 12.0.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Text(
            _restingHeartRateMessage,
            textAlign: TextAlign.center,
            style: textStyle14400().merge(const TextStyle(color: AppColor.black, height: 17.5 / 14)),
          ),
        ),
        SizedBox(height: 24.0.sp),
        SizedBox(
          width: widthBar + 20.0.sp,
          child: Row(
            children: [
              SizedBox(width: widthBar * ((_value ?? 40) - 40) / range),
              AppImageWidget.asset(
                path: AppImage.ic_down,
                width: 20.0.sp,
                color: _restingHeartRateColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 2.0.sp),
        SizedBox(
          width: widthBar,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.violet,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
              SizedBox(width: 2.0.sp),
              Expanded(
                flex: 2,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
              SizedBox(width: 2.0.sp),
              Expanded(
                flex: 6,
                child: Container(
                  height: 12.0.sp,
                  decoration: BoxDecoration(
                    color: AppColor.red,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTouchable(
              onPressed: _onPressAge,
              padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
              child: Obx(() => Text(
                    '${StringConstants.age.tr}: ${_appController.currentUser.value.age ?? 30}',
                    style: textStyle18400().merge(const TextStyle(
                      shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.grayText2,
                    )),
                  )),
            ),
            SizedBox(width: 12.0.sp),
            AppTouchable(
              onPressed: _onPressGender,
              padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
              child: Obx(() {
                Map gender = AppConstant.listGender.firstWhere(
                    (element) => element['id'] == _appController.currentUser.value.genderId,
                    orElse: () => AppConstant.listGender[0]);
                return Text(
                  chooseContentByLanguage(gender['nameEN'], gender['nameVN']),
                  style: textStyle18400().merge(const TextStyle(
                    shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
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
              child: AppButton(
                onPressed: widget.onPressCancel,
                height: 60.0.sp,
                width: Get.width,
                color: AppColor.red,
                radius: 10.0.sp,
                child: Text(
                  StringConstants.cancel.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: AppButton(
                height: 60.0.sp,
                width: Get.width,
                onPressed: () => widget.onPressAdd!(_dateTime ?? DateTime.now(), _value ?? 0),
                color: AppColor.primaryColor,
                radius: 10.0.sp,
                child: Text(
                  StringConstants.add.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

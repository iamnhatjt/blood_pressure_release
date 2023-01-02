import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/translation/app_translation.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_button.dart';

showDialogSuccess(
  BuildContext context,
  String titleText,
  String messageText, {
  String secondButtonText = '',
  VoidCallback? secondButtonCallback,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AppDialog(
      title: titleText,
      firstButtonText: TranslationConstants.close.tr,
      secondButtonText: secondButtonText,
      secondButtonCallback: secondButtonCallback,
      widgetBody: Column(
        children: [
          SizedBox(height: 40.0.sp),
          Text(
            messageText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              height: 24 / 20,
            ),
          ),
          SizedBox(height: 36.0.sp),
        ],
      ),
    ),
  );
}

Future showAppDialog(
  BuildContext context,
  String titleText,
  String messageText, {
  Widget? messageWidget,
  Widget? widgetBody,
  Widget? widgetTopRight,
  Widget? coverScreenWidget,
  String? firstButtonText,
  VoidCallback? firstButtonCallback,
  String? secondButtonText,
  VoidCallback? secondButtonCallback,
  bool dismissAble = false,
  WidgetBuilder? builder,
  Color? backgroundColor,
  double? heightDialog,
  double? widthDialog,
  bool? hideGroupButton,
  Widget? fullContentWidget,
  EdgeInsetsGeometry? padding,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissAble,
    builder: builder ??
        (BuildContext context) => AppDialog(
              title: titleText,
              message: messageText,
              messageWidget: messageWidget,
              widgetBody: widgetBody,
              widgetTopRight: widgetTopRight,
              coverScreenWidget: coverScreenWidget,
              firstButtonCallback: firstButtonCallback,
              secondButtonText: secondButtonText,
              secondButtonCallback: secondButtonCallback,
              backgroundColor: backgroundColor,
              heightDialog: heightDialog,
              widthDialog: widthDialog,
              hideGroupButton: hideGroupButton,
              fullContentWidget: fullContentWidget,
              firstButtonText: firstButtonText ??
                  TranslationConstants.cancel.tr,
              padding: padding,
            ),
  );
}

class AppDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? messageWidget;
  final bool dismissAble;
  final Widget? widgetBody;
  final Widget? widgetTopRight;
  final Widget? coverScreenWidget;
  final String firstButtonText;
  final VoidCallback? firstButtonCallback;
  final String? secondButtonText;
  final VoidCallback? secondButtonCallback;
  final Color? backgroundColor;
  final double? heightDialog;
  final double? widthDialog;
  final bool? hideGroupButton;
  final Widget? fullContentWidget;
  final EdgeInsetsGeometry? padding;
  final bool hasScroll;

  const AppDialog({
    Key? key,
    this.title,
    this.message,
    this.messageWidget,
    this.dismissAble = false,
    this.widgetBody,
    this.widgetTopRight,
    this.coverScreenWidget,
    required this.firstButtonText,
    this.firstButtonCallback,
    this.secondButtonText,
    this.secondButtonCallback,
    this.backgroundColor,
    this.heightDialog,
    this.widthDialog,
    this.hideGroupButton,
    this.fullContentWidget,
    this.padding,
    this.hasScroll = false,
  }) : super(key: key);

  Widget _buildGroupButtons() {
    if ((secondButtonText ?? '').isEmpty) {
      return AppButton(
        height: 60.0.sp,
        width: Get.width,
        onPressed: firstButtonCallback ?? Get.back,
        text: firstButtonText,
        color: AppColor.primaryColor,
        radius: 10.0.sp,
        child: Text(
          firstButtonText,
          textAlign: TextAlign.center,
          style: textStyle24700(),
        ),
      );
    }
    return Row(
      children: [
        Expanded(
          child: AppButton(
            onPressed: secondButtonCallback,
            height: 60.0.sp,
            width: Get.width,
            text: secondButtonText,
            color: AppColor.red,
            radius: 10.0.sp,
            child: Text(
              secondButtonText ?? '',
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
            onPressed: firstButtonCallback ?? Get.back,
            text: firstButtonText,
            color: AppColor.primaryColor,
            radius: 10.0.sp,
            child: Text(
              firstButtonText,
              textAlign: TextAlign.center,
              style: textStyle24700(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var dialogWidth = min<double>(width * 0.86, 400);
    return WillPopScope(
      onWillPop: () async => dismissAble,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.sp),
        ),
        elevation: 0.0,
        backgroundColor:
            backgroundColor ?? Colors.transparent,
        child: SingleChildScrollView(
          physics: !hasScroll
              ? const NeverScrollableScrollPhysics()
              : null,
          child: Stack(
            children: [
              fullContentWidget ??
                  Container(
                    decoration: BoxDecoration(
                      color:
                          backgroundColor ?? AppColor.white,
                      borderRadius:
                          BorderRadius.circular(20.0.sp),
                    ),
                    width: widthDialog ?? dialogWidth,
                    height: heightDialog,
                    padding:
                        padding ?? EdgeInsets.all(10.0.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (title ?? '').isNotEmpty
                            ? Text(
                                title!,
                                textAlign: TextAlign.center,
                                style: textStyle20700()
                                    .merge(const TextStyle(
                                        color: AppColor
                                            .black)),
                              )
                            : const SizedBox.shrink(),
                        (message ?? '').isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0.sp),
                                child: Text(
                                  message!,
                                  textAlign:
                                      TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        AppColor.grayText,
                                    fontSize: 16.0.sp,
                                    fontWeight:
                                        FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        widgetBody ??
                            Column(
                              children: [
                                (message ?? '').isEmpty
                                    ? const SizedBox
                                        .shrink()
                                    : Text(
                                        message!,
                                        overflow:
                                            TextOverflow
                                                .ellipsis,
                                        textAlign: TextAlign
                                            .center,
                                        style: TextStyle(
                                            color: AppColor
                                                .white,
                                            fontSize:
                                                16.0.sp,
                                            fontWeight:
                                                FontWeight
                                                    .w300),
                                      ),
                                messageWidget ??
                                    const SizedBox.shrink(),
                              ],
                            ),
                        hideGroupButton == true
                            ? const SizedBox.shrink()
                            : _buildGroupButtons(),
                      ],
                    ),
                  ),
              Positioned.fill(
                  child: coverScreenWidget ??
                      const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}

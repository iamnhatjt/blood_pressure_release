import 'dart:async';

import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_loading.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscribeScreen extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Function()? onRestored;

  const SubscribeScreen({
    super.key,
    required this.child,
    required this.onRestored,
    this.padding,
  });

  @override
  SubscribeScreenState createState() => SubscribeScreenState();
}

class SubscribeScreenState extends State<SubscribeScreen> {
  bool showButtonClose = false;
  int secondCountToCloseSubDialog = 5;

  @override
  void initState() {
    super.initState();
    showButtonClose = false;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondCountToCloseSubDialog == 1) {
        timer.cancel();
        setState(() {
          showButtonClose = true;
        });
      } else {
        setState(() {
          secondCountToCloseSubDialog = secondCountToCloseSubDialog - 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppContainer(
          isShowBanner: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppHeader(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                leftWidget: showButtonClose
                    ? AppTouchable(
                        onPressed: Get.back,
                        width: 40.sp,
                        height: 40.sp,
                        child: const Icon(
                          Icons.close_rounded,
                          // size: 18.sp,
                          color: AppColor.black,
                        ),
                      )
                    : SizedBox(
                        width: 40.sp,
                        height: 40.sp,
                      ),
                rightWidget: AppTouchable(
                  onPressed: widget.onRestored,
                  height: 40.sp,
                  padding: EdgeInsets.symmetric(horizontal: 22.sp),
                  child: Text("Restore",
                      style: ThemeText.caption.copyWith(
                        color: !isNullEmpty(widget.onRestored)
                            ? AppColor.black
                            : AppColor.gray2,
                      )),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.sp),
                    child: Text(
                      TranslationConstants.subscribeTitle.tr,
                      style: ThemeText.headline6
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.sp),
                  AppImageWidget.asset(
                    path: AppImage.subscribeImg,
                    height: 153.sp,
                  ),
                  SizedBox(height: 8.sp),
                  Expanded(
                      child: Padding(
                          padding: widget.padding ??
                              EdgeInsets.symmetric(horizontal: 48.sp),
                          child: widget.child)),
                  SizedBox(height: 4.sp),
                ],
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.sp).copyWith(
                    bottom: MediaQuery.of(context).padding.bottom + 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTouchable(
                        onPressed: () {
                          _openLink(AppExternalUrl.privacy);
                        },
                        padding: EdgeInsets.all(4.sp),
                        child: Text(
                          TranslationConstants.privacyPolicy.tr,
                          style: ThemeText.caption
                              .copyWith(decoration: TextDecoration.underline),
                        )),
                    AppTouchable(
                        onPressed: () {
                          _openLink(AppExternalUrl.termsAndConditions);
                        },
                        padding: EdgeInsets.all(4.sp),
                        child: Text(
                          TranslationConstants.termService.tr,
                          style: ThemeText.caption
                              .copyWith(decoration: TextDecoration.underline),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        !isNullEmpty(widget.onRestored) ? const SizedBox() : const AppLoading(),
      ],
    );
  }

  _openLink(String url) async {
    Uri uri = Uri.parse(url);
    await canLaunchUrl(uri)
        ? await launchUrl(uri)
        : throw 'Could not launch $url';
  }
}

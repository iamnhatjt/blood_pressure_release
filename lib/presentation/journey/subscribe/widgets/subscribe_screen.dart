import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/constants/app_constant.dart';
import '../../../../common/util/app_util.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/app_loading.dart';
import '../../../widget/app_touchable.dart';

class SubscribeScreen extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Function()? onRestored;
  final Function()? onPressBack;

  const SubscribeScreen({
    super.key,
    required this.child,
    required this.onRestored,
    this.padding,
    this.onPressBack,
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
                // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                middleWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TranslationConstants.subscribeTitle.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.0.sp),
                      padding: EdgeInsets.symmetric(
                          vertical: 4.0.sp, horizontal: 8.0.sp),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFB904),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text('PRO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ))
                          .animate(

                              onPlay: (controller) =>
                                  controller.repeat(reverse: false),
                              delay: 2000.ms, )

                          .shake(delay: 400.ms, duration: 500.ms,hz: 1),
                    )
                  ],
                ),

                // rightWidget: AppTouchable(
                //   onPressed: widget.onRestored,
                //   height: 40.sp,
                //   padding: EdgeInsets.symmetric(horizontal: 22.sp),
                //   child: Text("Restore",
                //       style: ThemeText.caption.copyWith(
                //         color: !isNullEmpty(widget.onRestored) ? AppColor.black : AppColor.gray2,
                //       )),
                // ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 20.0.sp),
                  Expanded(
                      child: Padding(
                          padding: widget.padding ??
                              EdgeInsets.symmetric(horizontal: 48.sp),
                          child: widget.child)),
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
                          style: const TextStyle(
                              color: Color(0xFF646464),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              decoration: TextDecoration.underline),
                        )),
                    AppTouchable(
                        onPressed: () {
                          _openLink(AppExternalUrl.termsAndConditions);
                        },
                        padding: EdgeInsets.all(4.sp),
                        child: Text(
                          TranslationConstants.termService.tr,
                          style: const TextStyle(
                              color: Color(0xFF646464),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              decoration: TextDecoration.underline),
                        )),
                    AppTouchable(
                        onPressed: widget.onRestored,
                        padding: EdgeInsets.all(4.sp),
                        child: Text(
                          TranslationConstants.restore.tr,
                          style: const TextStyle(
                              color: Color(0xFF646464),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              decoration: TextDecoration.underline),
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

import 'dart:developer';

import 'package:applovin_max/applovin_max.dart';
import 'package:bloodpressure/build_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/app_controller.dart';
import '../theme/app_color.dart';

class AppContainer extends GetView {
  const AppContainer({
    Key? key,
    this.appBar,
    this.onWillPop,
    this.bottomNavigationBar,
    this.child,
    this.backgroundColor,
    this.coverScreenWidget,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
    this.alignLayer,
    this.isShowBanner = true,
  }) : super(key: key);

  final AlignmentDirectional? alignLayer;
  final PreferredSizeWidget? appBar;
  final Future<bool> Function()? onWillPop;
  final Widget? bottomNavigationBar;
  final Widget? child;
  final Color? backgroundColor;
  final Widget? coverScreenWidget;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final bool isShowBanner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Stack(
        alignment:
            alignLayer ?? AlignmentDirectional.topStart,
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus =
                  FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset:
                  resizeToAvoidBottomInset,
              backgroundColor:
                  backgroundColor ?? AppColor.white,
              appBar: appBar,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: Column(
                  children: [
                    Expanded(
                        child: child ??
                            const SizedBox.shrink()),
                    isShowBanner
                        ? Obx(() => Get.find<
                                    AppController>()
                                .isPremiumFull
                                .value
                            ? const SizedBox.shrink()
                            : Padding(
                                padding:
                                    EdgeInsets.symmetric(
                                        vertical: 4.sp, horizontal: 20.0.sp),
                                child: MaxAdView(
                                  adUnitId: BuildConstants
                                      .idBannerAd,
                                  adFormat: AdFormat.banner,
                                  listener:
                                      AdViewAdListener(
                                    onAdLoadedCallback:
                                        (ad) {
                                      log('---ADS BANNER---onAdLoadedCallback');
                                    },
                                    onAdLoadFailedCallback:
                                        (adUnitId, error) {
                                      log('---ADS BANNER---onAdLoadFailedCallback: $error');
                                    },
                                    onAdClickedCallback:
                                        (ad) {
                                      log('---ADS BANNER---onAdClickedCallback');
                                    },
                                    onAdExpandedCallback:
                                        (ad) {
                                      log('---ADS BANNER---onAdExpandedCallback');
                                    },
                                    onAdCollapsedCallback:
                                        (ad) {
                                      log('---ADS BANNER---onAdCollapsedCallback');
                                    },
                                  ),
                                ),
                              ))
                        : const SizedBox(),
                  ],
                ),
              ),
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          ),
          coverScreenWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class DisableTouchWidget extends StatelessWidget {
  const DisableTouchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: const AbsorbPointer(
        absorbing: true,
      ),
    );
  }
}

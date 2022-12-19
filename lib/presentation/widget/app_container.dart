import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: backgroundColor ?? AppColor.white,
              appBar: appBar,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: child ?? const SizedBox.shrink(),
              ),
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          ),
          coverScreenWidget ?? const SizedBox.shrink(),
        ],
        alignment: alignLayer ?? AlignmentDirectional.topStart,
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

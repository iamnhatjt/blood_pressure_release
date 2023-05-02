import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_image_widget.dart';
import 'app_touchable.dart';

class BloodHeaderWidget extends StatelessWidget {
  final String title;
  final Color background;
  final Widget extendWidget;
  final Function() onExported;
  final LoadedType? exportLoaded;
  final bool isLoading;

  const BloodHeaderWidget({
    super.key,
    required this.title,
    required this.background,
    required this.extendWidget,
    required this.onExported,
    required this.isLoading,
    this.exportLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      title: title,
      titleStyle: IosTextStyle.StyleHeaderApp,
      leftWidget: const IosLeftHeaderWidget(),
      rightWidget: const IosRightHeaderWidget(),
    );
  }
}

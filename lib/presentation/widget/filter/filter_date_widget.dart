import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'filter_widget.dart';

class FilterDateWidget extends StatelessWidget {
  final Function()? onPressed;
  final DateTime startDate;
  final DateTime endDate;

  const FilterDateWidget(
      {Key? key,
      this.onPressed,
      required this.startDate,
      required this.endDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    return FilterWidget(
      onPressed: onPressed,
      title: '${DateFormat(
        'MMM dd, yyyy',
        appController.currentLocale.languageCode,
      ).format(startDate)} - ${DateFormat(
        'MMM dd, yyyy',
        appController.currentLocale.languageCode,
      ).format(endDate)}',
    );
  }
}

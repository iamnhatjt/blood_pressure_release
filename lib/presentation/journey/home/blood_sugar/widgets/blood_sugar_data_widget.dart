import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/widgets/statistical_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'blood_sugar_detail_widget.dart';

class BloodSugarDataWidget extends GetWidget<BloodSugarController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12.sp,),
          BloodSugarStatisticalWidget(
            rxAverage: controller.rxAverage,
            rxMin: controller.rxMin,
            rxMax: controller.rxMax,
          ),
          SizedBox(height: 12.sp,),
          const BloodSugarDetailWidget(),
        ],
      ),
    );
  }
}

import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BloodSugarInformationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: TranslationConstants.bloodSugar.tr, firstButtonText: 'Ok',
      widgetBody: Column(
        children: bloodSugarInformationCodeList.map((info) {
          Color color = AppColor.blue98EB;
          String title = '';
          String content = '';
          return SizedBox();
          // switch (info) {
          //   case BloodSugarInformationCode.lowCode:
          //     color = AppColor.blue98EB;
          //     title = TranslationConstants.bloodSugarInforLow.tr;
          //     content = '<'
          // }
        }).toList(),
      ),
    );
  }

}
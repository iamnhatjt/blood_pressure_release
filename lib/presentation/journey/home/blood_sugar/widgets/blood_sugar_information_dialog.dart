import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodSugarInformationDialog extends StatelessWidget {
  final String unit;
  final String state;

  const BloodSugarInformationDialog(
      {super.key, required this.unit, required this.state});

  Widget _buildItemWidget(
      {required Color color, required String title, required String content}) {
    return Container(
      height: 40.sp,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.sp),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(8.sp)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Row(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: ThemeText.subtitle2.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white),
            ),
          )),
          Text(
            content,
            style: ThemeText.subtitle2.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.white),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> informationMap = bloodSugarInformationMmolMap;
    if (unit == 'mg/dL') {
      informationMap = bloodSugarInformationMgMap;
    }
    return AppDialog(
      title: "${TranslationConstants.bloodSugar.tr} ($unit)",
      firstButtonText: 'Ok',
      widgetBody: Column(
        children: [
          SizedBox(
            height: 20.sp,
          ),
          AppTouchable(
              width: double.infinity,
              onPressed: null,
              backgroundColor: AppColor.lightGray,
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
              child: Text(
                "${TranslationConstants.bloodSugarState.tr}: $state",
                style: textStyle18500(),
              )),
          SizedBox(height: 32.sp,),
          Column(
            children: bloodSugarInformationCodeList.map((info) {
              Color color = AppColor.blue98EB;
              String title = '';
              String content = '';
              switch (info) {
                case BloodSugarInformationCode.lowCode:
                  color = AppColor.blue98EB;
                  title = TranslationConstants.bloodSugarInforLow.tr;
                  content = informationMap[info] ?? '';
                  break;
                case BloodSugarInformationCode.normalCode:
                  color = AppColor.green;
                  title = TranslationConstants.bloodSugarInforNormal.tr;
                  content = informationMap[info] ?? '';
                  break;
                case BloodSugarInformationCode.preDiabetesCode:
                  color = AppColor.gold;
                  title = TranslationConstants.bloodSugarInforPreDiabetes.tr;
                  content = informationMap[info] ?? '';
                  break;
                case BloodSugarInformationCode.diabetesCode:
                  color = AppColor.lightRed;
                  title = TranslationConstants.bloodSugarInforDiabetes.tr;
                  content = informationMap[info] ?? '';
                  break;
              }
              return _buildItemWidget(
                  color: color, title: title, content: content);
            }).toList(),
          ),
          SizedBox(
            height: 72.sp,
          )
        ],
      ),
    );
  }
}

import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodSugarInformationDialog extends StatelessWidget {
  final String unit;
  final String state;

  const BloodSugarInformationDialog(
      {super.key, required this.unit, required this.state});

  Widget _buildItemWidget(
      {required Color color, required String title, required String content, required String type}) {
    return Container(
      // height: 40.sp,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.sp),
      decoration: BoxDecoration(


          color: color, borderRadius: BorderRadius.circular(8.sp)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.0.sp),
      child: InnerShadow(
        shadows: [
          BoxShadow(
              color: Color(0xFF000000).withOpacity(0.15),
              offset: Offset(0,0),
              blurRadius: 5,
              spreadRadius: -1
          )
        ],
        child: Row(
          children: [
            Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: ThemeText.subtitle2.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: bloodSugarInfoColorTextMap[type]),
                  ),
                )),
            Text(
              content,
              style: ThemeText.subtitle2.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color:  bloodSugarInfoColorTextMap[type]),
            )
          ],
        ),
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
      firstButtonText: 'OK',
      widgetBody: Column(
        children: [
          SizedBox(
            height: 20.sp,
          ),
          ButtonIos3D.WhiteButtonUsal(
              width: double.infinity,
              radius: 10,
              onPress: null,
              backgroundColor: const Color(0xFFFFFFFF),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: Center(
                  child: Text(
                    "${TranslationConstants.bloodSugarState.tr}: $state",
                    style: textStyle16500().copyWith(color: const Color(0xFF646464)),
                  ),
                ),
              )),
          SizedBox(height: 32.sp,),
          Column(
            children: bloodSugarInformationCodeList.map((info) {
              String title = '';
              String content = '';
              switch (info) {
                case BloodSugarInformationCode.lowCode:
                  title = TranslationConstants.bloodSugarInforLow.tr;
                  content = informationMap[info] ?? '';
                  break;
                case BloodSugarInformationCode.normalCode:
                  title = TranslationConstants.bloodSugarInforNormal.tr;
                  content = informationMap[info] ?? '';
                  break;
                case BloodSugarInformationCode.preDiabetesCode:
                  title = TranslationConstants.bloodSugarInforPreDiabetes.tr;
                  content = informationMap[info] ?? '';
                  break;
                case BloodSugarInformationCode.diabetesCode:
                  title = TranslationConstants.bloodSugarInforDiabetes.tr;
                  content = informationMap[info] ?? '';
                  break;
              }
              return _buildItemWidget(
                  type: info,
                  color: bloodSugarInfoColorMap[info] ?? AppColor.blue98EB, title: title, content: content);
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


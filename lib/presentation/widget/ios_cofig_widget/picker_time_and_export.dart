import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/subscribe/ios/ios_subscribe_screen.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../../journey/home/blood_sugar/widgets/filter_state_widget.dart';




class PickTimeAndExport extends StatelessWidget {
  final bool? isChart;
  final Function() pickerTimeClick;
  final Widget textTime;
  final Function() exportClick;

  const PickTimeAndExport(
      {Key? key,
      required this.pickerTimeClick,
      required this.textTime,
      required this.exportClick,
      this.isChart = false})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          borderRadius: !isChart!
              ? BorderRadius.circular(16.0)
              : const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: const Color(0xFFF4FAFF)),
      padding: EdgeInsets.only(
          left: 15.0.sp, top: 15.0.sp, bottom: 15.0.sp, right: 15.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonIos3D.WhiteButtonUsal(
            child: textTime,
            onPress: pickerTimeClick,
            radius: 10.0.sp,
          ),
          ButtonIos3D(
            innerColor: const Color(0xFF40A4FF).withOpacity(0.25),
            dropColor: const Color(0xFF40A4FF).withOpacity(0.25),
            offsetInner: Offset(0,-2),
            offsetDrop: Offset(0,1),
            onPress: exportClick,
            radius: 10,
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.0.sp, vertical: 8.0.sp),
            child: Text(
              TranslationConstants.export.tr,
              style: const TextStyle(
                color: Color(0xff40A4FF),
                fontWeight: FontWeight.w500,
                fontSize: 18,

              ),
            ),

          ),)

        ],
      ),
    );
  }
}




class PickTimeAndExportSugar extends StatelessWidget {
  final bool? isChart;
  final Function() pickerTimeClick;
  final Widget textTime;
  final Function() exportClick;

  const PickTimeAndExportSugar(
      {Key? key,
        required this.pickerTimeClick,
        required this.textTime,
        required this.exportClick,
        this.isChart = false})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          borderRadius: !isChart!
              ? BorderRadius.circular(16.0)
              : const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: const Color(0xFFF4FAFF)),
      padding: EdgeInsets.only(
          left: 15.0.sp, top: 15.0.sp, bottom: 15.0.sp, right: 15.0.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonIos3D.WhiteButtonUsal(
                child: textTime,
                onPress: pickerTimeClick,
                radius: 10.0.sp,
              ),
              ButtonIos3D(
                innerColor: const Color(0xFF40A4FF).withOpacity(0.25),
                dropColor: const Color(0xFF40A4FF).withOpacity(0.25),
                offsetInner: Offset(0,-2),
                offsetDrop: Offset(0,1),
                onPress: (){
                  Get.find<AppController>().isPremiumFull.value ? Get.to(IosSubscribeScreen()) :
                      exportClick();
                },
                radius: 10,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.0.sp, vertical: 8.0.sp),
                  child: Text(
                    TranslationConstants.export.tr,
                    style: const TextStyle(
                      color: Color(0xff40A4FF),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,

                    ),
                  ),

                ),)

            ],
          ),
          SizedBox(height: 8.0.sp,),
          const FilterStateWidget()
        ],
      ),
    );
  }
}

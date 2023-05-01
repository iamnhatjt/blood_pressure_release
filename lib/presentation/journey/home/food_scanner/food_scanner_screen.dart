import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_add_button.dart';
import 'package:bloodpressure/presentation/journey/home/food_scanner/food_scanner_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/widget_buton_handle_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class FoodScannerScreen extends GetView<FoodScannerController> {
  const FoodScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      isShowBanner: false,
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.scanFood.tr,
            leftWidget: const IosLeftHeaderWidget(),
            titleStyle: IosTextStyle.StyleHeaderApp,
            rightWidget: Obx(

              () => AppTouchable.common(
                onPressed: controller.toggleFlash,
                decoration: const BoxDecoration(boxShadow: null),
                child: Icon(
                  controller.isFlashOn.value
                      ? Icons.flash_on_rounded
                      : Icons.flash_off_rounded,
                  color: controller.isFlashOn.value
                      ? AppColor.gold
                      : AppColor.black,
                ),
              ),
            ),
          ),

          Expanded(child: Obx(() {
            if (controller.isLoadingQrCamera.value) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            switch (controller.permissionStatusCamera.value) {
              case PermissionStatus.denied:
                return _permissionDenied(context);
              case PermissionStatus.granted:
              case PermissionStatus.restricted:
              case PermissionStatus.limited:
                return _scannerView();
              case PermissionStatus.permanentlyDenied:
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(TranslationConstants.permissionCameraDenied01.tr),
                      SizedBox(
                        height: 12.0.sp,
                      ),
                      AppTouchable(
                        onPressed: () {
                          controller.onPressRequestPermissionCamera(context);
                        },
                        child: Text(TranslationConstants.requestPermission.tr),
                      ),
                    ],
                  ),
                );
            }
          })),
        ],
      ),
    );
  }

  Widget _scannerView() {
    return Column(
      children: [
        SizedBox(
          height: 360.0.sp,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0.sp),
            child: QRView(
              key: controller.qrCameraKey,
              onQRViewCreated: controller.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: AppColor.primaryColor,
                  borderWidth: 5.0.sp,
                  borderRadius: 10.0.sp,
                  cutOutWidth: controller.selectedDataMapTypeTab["id"] == 1
                      ? 330.0.sp
                      : 280.0.sp,
                  cutOutHeight:
                      controller.selectedDataMapTypeTab.value['id'] == 1
                          ? 120.0.sp
                          : 280.0.sp),
            ),
          ),
        ),
        SizedBox(
          height: 32.0.sp,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.listDataMapTypeTab.map(
              (type) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0.sp),
                  child: ButtonIos3D(
                    height: 40.0.sp,
                    width: 80.0.sp,
                    innerColor: controller.selectedDataMapTypeTab == type
                        ? const Color(0xFF000000)
                        .withOpacity(0.15)
                        : Color(0xFF000000).withOpacity(0.15),
                    dropColor: controller.selectedDataMapTypeTab == type
                        ? Colors.transparent
                        : Colors.black.withOpacity(0.25),
                    offsetInner: controller.selectedDataMapTypeTab == type
                        ? Offset(0, -4)
                        : Offset(0, -2),
                    offsetDrop: Offset(0, 1),
                    radius: 10,
                    backgroundColor:controller.selectedDataMapTypeTab == type
                        ? const Color(0xFF5298EB)
                        : Colors.white,


                    onPress: () {
                      return controller.selectedDataMapTypeTab.value = type;
                    },
                    child: Center(
                      child: Text(
                        type["name"],
                        style: textStyle16400().copyWith(
                          color: controller.selectedDataMapTypeTab == type
                              ? AppColor.white
                              : AppColor.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(growable: false),
          ),
        )
      ],
    );
  }

  Widget _permissionDenied(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TranslationConstants.permissionCameraDenied02.tr,
            textAlign: TextAlign.center,
            style: textStyle16400(),
          ),
          SizedBox(
            height: 12.0.sp,
          ),
          AppTouchable.commonRadius20(
            onPressed: () {
              controller.onPressRequestPermissionCamera(context);
            },
            backgroundColor: AppColor.green,
            padding: EdgeInsets.symmetric(
              vertical: 12.0.sp,
              horizontal: 20.0.sp,
            ),
            child: Text(
              TranslationConstants.requestPermission.tr,
              style: textStyle16500().copyWith(
                color: AppColor.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

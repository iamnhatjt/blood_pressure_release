import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/disable_glow_behavior.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../controller/app_controller.dart';
import '../../theme/app_color.dart';
import '../../theme/theme_text.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/country_picker/country_picker.dart';
import 'select_location_controller.dart';

class SelectLocationScreen extends GetView<SelectLocationController> {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        isShowBanner: false,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            AppImageWidget.asset(
              path: AppImage.icSelectLocation,
              height: Get.height * 0.24,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: DisableGlowBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.sp, vertical: 20.0.sp),
                        child: Text(TranslationConstants.selectLocation.tr,
                            style: ThemeText.headline6, textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.sp, vertical: 14.0.sp),
                        child: Text(TranslationConstants.howOldAreYou.tr,
                            style: ThemeText.headline6, textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(36.0.sp)),
                          child: Obx(() => DropdownButton(
                                value: controller.valueChose.value,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                menuMaxHeight: Get.height * 0.2,
                                isExpanded: true,
                                underline: const SizedBox(),
                                items: controller.listItemAge.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Center(child: Text(valueItem.toString())),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.valueChose.value = value as int;
                                },
                              )),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.sp, vertical: 14.0.sp),
                        child: Text(TranslationConstants.whatGender.tr,
                            style: ThemeText.headline6, textAlign: TextAlign.center),
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => controller.onPressMale(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                          child: Obx(() => Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                                decoration: BoxDecoration(
                                    color: controller.isMale.value ? const Color(0xFF4FBE1B) : Colors.white,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: controller.isMale.value ? Colors.transparent : Colors.grey),
                                    borderRadius: BorderRadius.circular(36.0.sp)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
                                  child: Center(
                                    child: Text(
                                      TranslationConstants.male.tr,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: controller.isMale.value ? AppColor.white : AppColor.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => controller.onPressFemale(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                          child: Obx(() => Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                                decoration: BoxDecoration(
                                    color: controller.isFemale.value ? const Color(0xFF4FBE1B) : Colors.white,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: controller.isFemale.value ? Colors.transparent : Colors.grey),
                                    borderRadius: BorderRadius.circular(36.0.sp)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
                                  child: Center(
                                    child: Text(
                                      TranslationConstants.female.tr,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: controller.isFemale.value ? AppColor.white : AppColor.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.sp, vertical: 14.0.sp),
                        child: Text(TranslationConstants.questionWhere.tr,
                            style: ThemeText.headline6, textAlign: TextAlign.center),
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: const CountryListThemeData(
                              flagSize: 25,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                              bottomSheetHeight: 500,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            showSearch: false,
                            onSelect: (Country country) async {
                              AppController appController = Get.find<AppController>();
                              final prefs = await SharedPreferences.getInstance();

                              controller.location.value = country.name;

                              switch (country.name) {
                                case "Australia":
                                  appController.userLocation.value = "Australia";
                                  prefs.setString("user_location", "Australia");
                                  break;

                                case "United Kingdom":
                                  appController.userLocation.value = "UK";
                                  prefs.setString("user_location", "UK");
                                  break;

                                case "Canada":
                                  appController.userLocation.value = "Canada";
                                  prefs.setString("user_location", "Canada");
                                  break;

                                case "United States":
                                  appController.userLocation.value = "USA";
                                  prefs.setString("user_location", "USA");
                                  break;

                                default:
                                  appController.userLocation.value = "Other";
                                  prefs.setString("user_location", "Other");
                              }
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                          child: Obx(() => Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(36.0.sp)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
                                  child: Center(
                                    child: Text(
                                      controller.location.value,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.04),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => controller.onPressNext(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 4.0.sp),
                            decoration: BoxDecoration(
                                color: const Color(0xFFFF6464),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(36.0.sp)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
                              child: Center(
                                child: Text(
                                  TranslationConstants.next.tr,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/heart_beat/heart_beat_controller.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/widget_buton_handle_data.dart';
import 'package:bloodpressure/presentation/widget/native_ads_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants/app_image.dart';
import '../../../../common/constants/app_route.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/model/heart_rate_model.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/app_heart_rate_chart_widget.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/ios_cofig_widget/Button_ios_3d.dart';
import '../../../widget/ios_cofig_widget/picker_time_and_export.dart';
import '../../main/widgets/subscribe_button.dart';

class HeartBeatScreen extends GetView<HeartBeatController> {
  const HeartBeatScreen({Key? key}) : super(key: key);

  Widget _buildChart() {
    return Padding(
      padding: EdgeInsets.only(right: 12.0.sp, top: 12.0.sp),
      child: Obx(() => AppHeartRateChartWidget(

            listChartData: controller.chartListData,
            minDate: controller.chartMinDate.value,
            maxDate: controller.chartMaxDate.value,
            selectedX: controller.chartSelectedX.value,
            onPressDot: (x, dateTime) {
              controller.chartSelectedX.value = x;
              HeartRateModel? checkedHeartRateModel;
              for (final item in controller.chartListData) {
                if (dateTime.isAtSameMomentAs(item['date'])) {
                  checkedHeartRateModel = controller.listHeartRateModelAll
                      .firstWhere(
                          (element) => item['timeStamp'] == element.timeStamp);
                  break;
                }
              }
              if (checkedHeartRateModel?.timeStamp !=
                  controller.currentHeartRateModel.value.timeStamp) {
                controller.currentHeartRateModel.value = checkedHeartRateModel!;
              }
            },
          )),
    );
  }

  Widget _buildBodyEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppImageWidget.asset(
              path: AppImage.iosHeartNoChart,
              width: Get.width / 3,
              height: Get.width / 3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 68.sp),
              child: Text(TranslationConstants.measureNowOrAdd.tr,
                  textAlign: TextAlign.center,
                  style: IosTextStyle.StyleBodyChartEmptyData),
            ),
          ],
        )),
        Obx(
          () {
            final isPremium = Get.find<AppController>().isPremiumFull.value;
            return isPremium
                ? const SizedBox.shrink():  SizedBox.shrink();
                // : NativeAdsWidget(
                //     factoryId: NativeFactoryId.appNativeAdFactorySmall,
                //     isPremium: isPremium);
          },
        ),
      ],
    );
  }

  Widget _buildBodyData() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
      decoration:  BoxDecoration(
        color: const Color(0xFFF4FAFF),
        borderRadius: BorderRadius.circular(16.0.sp),
      ),
      child: Column(
        children: [
          Obx(
            () => PickTimeAndExport(
                pickerTimeClick: controller.onPressDateRange,
                isChart: controller.listHeartRateModel.isNotEmpty,
                textTime: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0.sp, horizontal: 20.0.sp),
                    child: Text(
                      '${DateFormat('MMM dd, yyyy').format(controller.startDate.value)} - ${DateFormat('MMM dd, yyyy').format(controller.endDate.value)}',
                      style: IosTextStyle.IosTextPickTime,
                    )),
                exportClick: () {
                  Get.find<AppController>().isPremiumFull.value
                      ? controller.onPressExport()
                      : Get.toNamed(AppRoute.iosSub);
                }),
          ),
          Container(

            margin: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: ButtonIos3D.onlyInner(
              innerColor: const Color(0xFF89C7FF).withOpacity(0.5),
              radius: 16,
              offsetInner: const Offset(0, 0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            TranslationConstants.min.tr,
                            style: textStyle18400().copyWith(color: const  Color(0xFF646464)),
                          ),
                          Obx(() => Text(
                                '${controller.hrMin.value}',
                            style: textStyle22700().copyWith(color: const Color(0xFF646464)),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            TranslationConstants.average.tr,
                            style: textStyle18400().copyWith(color: const  Color(0xFF646464)),
                          ),
                          Obx(() => Text(
                                '${controller.hrAvg.value}',
                            style: textStyle22700().copyWith(color: const Color(0xFF646464)),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            TranslationConstants.max.tr,
                            style: textStyle18400().copyWith(color: const Color(0xFF646464)),
                          ),
                          Obx(() => Text(
                                '${controller.hrMax.value}',
                                style: textStyle22700().copyWith(color: const Color(0xFF646464)),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0.sp,
          ),
          Expanded(
            child: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 8.0.sp),
              margin: EdgeInsets.symmetric(horizontal: 17.0.sp),
              // decoration: commonDecoration(),
              child: _buildChart(),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical:12.0.sp, horizontal: 12.0.sp),
            child: ButtonIos3D.onlyInner(
              backgroundColor: Colors.white,
              innerColor: const Color(0xFF89C7FF),
              radius: 16,
              offsetInner: const Offset(0, 0),
              child: Obx(() {
                DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                    controller.currentHeartRateModel.value.timeStamp ?? 0);
                int value = controller.currentHeartRateModel.value.value ?? 40;
                String status = '';
                Color color = const Color(0xFF0B8C10);

                if (value < 60) {
                  status = TranslationConstants.slow.tr;
                  color = const Color(0xFFCF71FB);

                } else if (value > 100) {
                  status = TranslationConstants.fast.tr;
                  color = const Color(0xFFFF6C6C);
                } else {
                  status = TranslationConstants.normal.tr;
                  color = const Color(0xFF0B8C10);
                }
                return Container(

                  height: 92.0.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 12.0.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('MMM dd, yyyy').format(dateTime),
                                style: textStyle14400().copyWith(color: const Color(0xFF646464))),
                              SizedBox(height: 8.0.sp),
                              Text(
                                DateFormat('h:mm a').format(dateTime),
                                style: textStyle14400().copyWith(color: const Color(0xFF646464)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$value',
                              style: TextStyle(
                                fontSize: 37.0.sp,
                                fontWeight: FontWeight.w700,
                                color:const Color(0xFF606060),
                              ),
                            ),
                            SizedBox(height: 2.0.sp),
                            Text(
                              'BPM',
                              style:
                              textStyle14500().merge(const TextStyle(height: 1)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(CupertinoIcons.heart_fill, color: color,),
                                SizedBox(width: 4.0.sp),
                                Text(
                                  status,
                                  style: textStyle14500().copyWith(color: const Color(0xFF646464)),
                                ),
                                const Spacer(),
                                GestureDetector(onTap: controller.onPressDeleteData,child: const Icon(CupertinoIcons.delete_solid, color: Colors.red,))
                                ,SizedBox(width: 12.0.sp)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 4.0.sp),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      isShowBanner: true,
      child: Container(
        color: Colors.white,
        // margin: EdgeInsets.symmetric(horizontal: 8.0.sp),
        child: Column(children: [
          AppHeader(
            backgroundColor: Colors.white,
            title: TranslationConstants.heartRate.tr,

            leftWidget: const IosLeftHeaderWidget(
              isHome: false,
            ),
            // additionSpaceButtonLeft: 40.0.sp,
            rightWidget: const IosRightHeaderWidget(),
            titleStyle: IosTextStyle.StyleHeaderApp,
          ),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.red,
                    ),
                  )
                : controller.listHeartRateModel.isEmpty
                    ? _buildBodyEmpty()
                    : _buildBodyData()),
          ),
          SizedBox(height: 8.0.sp,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.onPressMeasureNow();
                  },
                  child:  Stack(
                    children: [
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: ButtonIos3D.onlyInner(
                          innerRadius: 4,
                            offsetInner: const Offset(0,-5),
                            innerColor: Colors.black.withOpacity(0.15),

                            radius: 20,
                            onPress: controller.onPressMeasureNow,
                            height: 70.0.sp,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: AppColorIOS.gradientWeightBMI,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              height: double.infinity,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                    width: 50,
                                  ),
                                  Expanded(
                                      child: Center(
                                        child: Text(TranslationConstants.measureNow.tr,
                                            style: IosTextStyle.f18w700w.copyWith(
                                                fontWeight: FontWeight.w700, fontSize: 24)),
                                      ))
                                ],
                              ),
                            )),
                      ),
                      Positioned(
                        top: 8.0.sp,
                        left: 16.0.sp,
                        child: AppImageWidget.asset(
                          path: AppImage.iosHeartBeat,
                          height: 52.0.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 12.0.sp,
                ),
                Row(
                  children: [
                    Expanded(
                        child: SetAlarmButton(
                            onPress: controller.onPressAddAlarm)),
                    SizedBox(
                      width: 20.0.sp,
                    ),
                    Expanded(
                        child: HandleSafeAndAdd(
                            onPress: controller.onPressAddData)),
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 17.0.sp),
              ],
            ),
          )

        ]),
      ),
    );
  }
}

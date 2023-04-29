import 'package:bloodpressure/common/injector/binding/blood_suagr_binding.dart';
import 'package:bloodpressure/common/injector/binding/food_scanner_binding.dart';
import 'package:bloodpressure/common/injector/binding/subscribe_bindings.dart';
import 'package:bloodpressure/common/injector/binding/weight_bmi_binding.dart';
import 'package:bloodpressure/presentation/journey/home/food_scanner/food_scanner_screen.dart';
import 'package:bloodpressure/presentation/journey/home/home_screen.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/weight_bmi_screen.dart';
import 'package:bloodpressure/presentation/journey/insight/insight_binding.dart';
import 'package:bloodpressure/presentation/journey/insight/insight_screen.dart';
import 'package:bloodpressure/presentation/journey/subscribe/android/android_subscribe_screen.dart';
import 'package:bloodpressure/presentation/journey/subscribe/ios/ios_subscribe_screen.dart';
import 'package:get/get.dart';

import '../common/constants/app_route.dart';
import '../common/injector/binding/blood_pressure_binding.dart';
import '../common/injector/binding/heart_beat_binding.dart';
import '../common/injector/binding/main_binding.dart';
import '../common/injector/binding/select_location_binding.dart';
import '../common/injector/binding/splash_binding.dart';
import 'journey/home/blood_pressure/blood_pressure_screen.dart';
import 'journey/home/blood_sugar/blood_sugar_screen.dart';
import 'journey/home/heart_beat/heart_beat_screen.dart';
import 'journey/home/heart_beat/measure/measure_screen.dart';
import 'journey/home/home_binding.dart';
import 'journey/main/main_screen.dart';
import 'journey/select_location/select_location_screen.dart';
import 'journey/splash/splash_screen.dart';

class AppPage {
  static final pages = [
    GetPage(name: AppRoute.splashScreen, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: AppRoute.selectLocation, page: () => const SelectLocationScreen(), binding: SelectLocationBinding()),
    GetPage(name: AppRoute.mainScreen, page: () => const MainScreen(), binding: MainBinding()),
    GetPage(name: AppRoute.heartBeatScreen, page: () => const HeartBeatScreen(), binding: HeartBeatBinding()),
    GetPage(name: AppRoute.measureScreen, page: () => const MeasureScreen(), binding: MeasureBinding()),
    GetPage(name: AppRoute.bloodPressureScreen, page: () => const BloodPressureScreen(), binding: BloodPressureBinding()),
    GetPage(name: AppRoute.bloodSugar, page: () => const BloodSugarScreen(), binding: BloodSugarBinding()),
    GetPage(name: AppRoute.weightBMI, page: () => const WeightBMIScreen(), binding: WeightBMIBinding()),
    GetPage(
      name: AppRoute.foodScanner,
      page: () => const FoodScannerScreen(),
      binding: FoodScannerBinding(),
    ),
    GetPage(
      name: AppRoute.iosSub,
      page: () => const IosSubscribeScreen(),
      binding: IosSubscribeBinding(),
    ),
    GetPage(
      name: AppRoute.androidSub,
      page: () => const AndroidSubscribeScreen(),
      binding: AndroidSubscribeBinding(),
    ),
    GetPage(
      name: AppRoute.insight,
      page: () => const InsightScreen(),
      binding: InsightBinding(),
    ),
    GetPage(
      name: AppRoute.insight,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}

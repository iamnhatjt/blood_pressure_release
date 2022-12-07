import 'package:bloodpressure/app/binding/heart_beat_binding.dart';
import 'package:bloodpressure/app/binding/main_binding.dart';
import 'package:bloodpressure/app/binding/measure_binding.dart';
import 'package:bloodpressure/app/ui/screen/main_screen.dart';
import 'package:get/get.dart';
import '../binding/splash_binding.dart';
import '../ui/screen/heart_beat_screen.dart';
import '../ui/screen/measure_screen.dart';
import '../ui/screen/splash_screen.dart';
import 'app_route.dart';

class AppPage {
  static final pages = [
    GetPage(name: AppRoute.splashScreen, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: AppRoute.mainScreen, page: () => const MainScreen(), binding: MainBinding()),
    GetPage(name: AppRoute.heartBeatScreen, page: () => const HeartBeatScreen(), binding: HeartBeatBinding()),
    GetPage(name: AppRoute.measureScreen, page: () => const MeasureScreen(), binding: MeasureBinding()),
  ];
}

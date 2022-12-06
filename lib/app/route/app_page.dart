import 'package:bloodpressure/app/binding/main_binding.dart';
import 'package:bloodpressure/app/ui/screen/main_screen.dart';
import 'package:get/get.dart';
import '../binding/splash_binding.dart';
import '../ui/screen/splash_screen.dart';
import 'app_route.dart';

class AppPage {
  static final pages = [
    GetPage(name: AppRoute.splashScreen, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: AppRoute.mainScreen, page: () => const MainScreen(), binding: MainBinding()),
  ];
}

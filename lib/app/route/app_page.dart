import 'package:get/get.dart';
import '../binding/splash_binding.dart';
import '../ui/screen/splash_screen.dart';
import 'app_route.dart';

class AppPage {
  static final pages = [
    GetPage(name: AppRoute.splashScreen, page: () => const SplashScreen(), binding: SplashBinding()),
  ];
}

import 'package:get/get.dart';
import 'package:weather_forecast/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(Routes.HOME);
    });
  }
}

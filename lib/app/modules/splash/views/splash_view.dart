import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: Center(
        child: Text(
          'Weather Forecast',
          style: TextStyle(fontSize: 30.sp),
        ),
      ),
    );
  }
}

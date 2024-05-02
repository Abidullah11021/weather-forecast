import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: 1.sw,
                height: 1.sh,
                child: Center(
                  child: Container(
                    width: 300.w,
                    height: 300.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 5,
                              color: Colors.grey.shade300)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "City name: ${controller.weather.cityName}",
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        Text(
                          "Temp: ${controller.weather.temperature} ",
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        Text(
                          "Condition: ${controller.weather.condition} ",
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Text(
                          "Humidity: ${controller.weather.humidity} ",
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Text(
                          "Wind Speed: ${controller.weather.windSpeed} ",
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

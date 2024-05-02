import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: 1.sw,
                height: 1.sh,
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    Container(
                      width: 1.sw,
                      height: 50.h,
                      padding: EdgeInsets.only(left: 10.w),
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.grey.shade300)
                          ],
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        children: [
                          /// text field for entering city name
                          Expanded(
                            child: TextField(
                              controller: cityController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter city name",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 20.sp),
                              ),
                            ),
                          ),

                          /// search icon button
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.r),
                                  bottomRight: Radius.circular(10.r)),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {
                                controller
                                    .fetchWeatherByCity(cityController.text);
                              },
                              child: Icon(
                                Icons.search_outlined,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    /// [weather details container]
                    Center(
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

                        /// showing weather details below
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City name: ${controller.weather.value.cityName}",
                                style: TextStyle(fontSize: 25.sp),
                              ),
                              Text(
                                "Temp: ${controller.weather.value.temperature} ",
                                style: TextStyle(fontSize: 25.sp),
                              ),
                              Text(
                                "Condition: ${controller.weather.value.condition} ",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              Text(
                                "Humidity: ${controller.weather.value.humidity} ",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              Text(
                                "Wind Speed: ${controller.weather.value.windSpeed} ",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

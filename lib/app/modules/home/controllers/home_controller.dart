import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/app/models/weather_model.dart';
import 'package:weather_forecast/app/utills/weather_service.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    weatherService = WeatherService(apiKey: weatherApiKey);
    determinePosition();
  }

  late Position position;
  double? latitude;
  double? longitude;
  LocationPermission? permission;
  String weatherApiKey = 'fa6daaf4450fa33c9e85933fbbd70d30';
  Rx<bool> isLoading = true.obs;
  late Rx<Weather> weather;
  late WeatherService weatherService;

  /// [check internet connection]
  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  /// [detect current location]
  Future<Position> determinePosition() async {
    log("determine position called");
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // log("requested permission");
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // log("permission denied");
        showDialogOnMap("Please enable location permission");
      } else {
        log("permission granted");
        try {
          position = await Geolocator.getCurrentPosition();
          latitude = position.latitude;
          longitude = position.longitude;
          log(latitude.toString());
          await fetchWeatherByLocation();
        } catch (e) {
          if ((e
              .toString()
              .contains("The location service on the device is disabled"))) {
            showDialogOnMap("Please turn on the location");
          }
          log("error in getting position $e");
        }
      }
    } else {
      log("permission granted already");
      try {
        position = await Geolocator.getCurrentPosition();
        latitude = position.latitude;
        log(latitude.toString());
        longitude = position.longitude;
        log(longitude.toString());
        await fetchWeatherByLocation();
      } catch (e) {
        if ((e
            .toString()
            .contains("The location service on the device is disabled"))) {
          showDialogOnMap("Please turn on the location");
        }
        log("error in getting position $e");
      }
    }

    return position;
  }

  /// [function for getting current location weather]
  Future<void> fetchWeatherByLocation() async {
    if (await checkConnectivity()) {
      var weatherDataResult =
          await weatherService.getWeatherByLocation(latitude!, longitude!);

      weather = Weather.fromJson(weatherDataResult).obs;

      isLoading.value = false;
    } else {
      Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.sp);
    }
  }

  /// [function for getting weather of entered city name by user]

  Future<void> fetchWeatherByCity(String cityName) async {
    if (await checkConnectivity()) {
      try {
        var weatherDataResult = await weatherService.getWeatherByCity(cityName);
        weather.value = Weather.fromJson(weatherDataResult);
      } on Exception catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.sp);
      }
    } else {
      Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.sp);
    }
  }

  void showDialogOnMap(String content) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (_) {
          return AlertDialog(
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () async {
                    Get.back();
                    determinePosition();
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  @override
  void onClose() {
    isLoading.close();
    weather.close();
    super.onClose();
  }
}

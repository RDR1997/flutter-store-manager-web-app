import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isObscure = true.obs;
  var isLoading = false.obs;

  var shopName = ''.obs;

  @override
  void onInit() {
    shopName.value = 'Ranatunga Motors';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}

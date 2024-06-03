import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:storemanager/controllers/ProductController.dart';
import 'package:storemanager/views/Home.dart';
import 'package:storemanager/views/Login.dart';
import '../Constants.dart';
import '../views/Components/LoginAlertBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Environment.dart';

class LoginController extends GetxController {
  final productController = Get.put(ProductController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isObscure = true.obs;
  var isLoading = false.obs;

  var loginMassage = ''.obs;
  var authToken = ''.obs;
  var userId = 1.obs;

  @override
  void onInit() {}

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

  void showToast(String message) {
    Get.snackbar(
      'Message', // Title of the Snackbar
      message, // Message of the Snackbar
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: colortheam1,
      colorText: fontColor,
      borderRadius: 8,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

  login(String name, String password) async {
    final url = "${Environment().api}/login";
    final response = await http.post(Uri.parse(url), body: {
      "username": name,
      "password": password,
    }, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      authToken.value = data['token'];
      productController.auth_token.value = data['token'];

      showToast('Successfully Logged In..!');
      await productController.getProducts();
      Get.off(Home());
    } else if (response.statusCode == 401) {
      showToast('Incorrect Username or Password');
    } else {
      showToast('Internal Server Error');
    }

    isLoading.value = false;
  }

  logout() async {
    isLoading.value = false;
  }
}

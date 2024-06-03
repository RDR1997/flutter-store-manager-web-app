import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:storemanager/controllers/LoginController.dart';
import 'package:storemanager/models/Products.dart';
import 'package:storemanager/views/Home.dart';
import 'package:storemanager/views/Login.dart';
import '../Constants.dart';
import '../views/Components/LoginAlertBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Environment.dart';

class ProductController extends GetxController {
  // final loginController = Get.put(LoginController());

  var productsList = <Product>[].obs;
  var userId = 1.obs;
  var auth_token = ''.obs;
  var selectedImageUrl = ''.obs;

  @override
  void onInit() {}

  @override
  void onReady() {
    super.onReady();
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

  getProducts() async {
    print('productss');
    var productsData = await fetchProducts();
    List<Product> productsDataList = productsData.products;

    productsList.value = productsDataList;
    print(productsList[0].id);
  }

  Future<Products> fetchProducts() async {
    final url = "${Environment().api}/product";

    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth_token}'
    });

    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else if (response.statusCode == 401) {
      showToast('Login session expired, login again');
      Get.off(Login());
    } else {
      showToast('Internal Sever Error');
    }
    return Products.fromJson(result);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storemanager/models/Products.dart';

class HomeController extends GetxController {
  var isObscure = true.obs;
  var isLoading = false.obs;
  var isMobile = false.obs;
  var startShopping = false.obs;

  var selectedProductsList = [].obs;

  var shopName = ''.obs;
  var activeIndex = 0.obs;

  @override
  void onInit() {
    shopName.value = 'Ranatunga Motors';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

updateProductQuantity(id,  name,  quantity,  price) {
    if (quantity > 0) {
      var product = {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price
      };

      // Check if the product exists in the list
      int index = selectedProductsList.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        // If the product exists, update it
        selectedProductsList[index] = product;
      } else {
        // If the product does not exist, add it to the list
        selectedProductsList.add(product);
      }
    } else {
      // Remove the product if the quantity is 0 or less
      selectedProductsList.removeWhere((item) => item['id'] == id);
    }
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  toggleStartShopping() {
    startShopping.value = !startShopping.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}

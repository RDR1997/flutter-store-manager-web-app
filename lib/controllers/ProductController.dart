import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:storemanager/controllers/HomeController.dart';
import 'package:storemanager/controllers/LoginController.dart';
import 'package:storemanager/models/Products.dart';
import 'package:storemanager/views/Home.dart';
import 'package:storemanager/views/Login.dart';
import '../Constants.dart';
import '../views/Components/LoginAlertBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Environment.dart';

class ProductController extends GetxController {
  // final homeController = Get.put(HomeController());
  // final loginController = Get.put(LoginController());

  var productsList = <Product>[].obs;
  var userId = 1.obs;
  var selectedBrand = ''.obs;
  var selectedBrandName = ''.obs;
  var selectedDistributor = ''.obs;
  var selectedDistributorName = ''.obs;
  var product_id = 0.obs;

  var auth_token = ''.obs;
  var selectedImageUrl = ''.obs;
  var productImagesConv = <String>[].obs;
  var productImages = <XFile>[].obs;
  final editProductNameController = TextEditingController();
  final editProductOtherNameController = TextEditingController();
  final editProductModelController = TextEditingController();
  final editProductQuantityController = TextEditingController();
  final editProductPriceController = TextEditingController();
  final editProductNoteController = TextEditingController();
  final editBrandController = TextEditingController();
  final editProductRackNumberController = TextEditingController();
  final editProductRackLevelController = TextEditingController();
  final editDistributorController = TextEditingController();
  final editDistributorPhoneNoController = TextEditingController();
  final editDistributorNoteController = TextEditingController();

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
    var productsData = await fetchProducts();
    List<Product> productsDataList = productsData.products;

    productsList.value = productsDataList;
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

  deleteProduct(product_id) async {
    print(product_id);
    final url = "${Environment().api}/product/$product_id";

    final response = await http.delete(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth_token}'
    });

    var result = jsonDecode(response.body);
  }

  getProductDataToEdit(index) {
    product_id.value = productsList[index].id;
    editProductNameController.text = productsList[index].name;
    editProductOtherNameController.text = productsList[index].otherName;
    editProductModelController.text = productsList[index].model;
    editProductQuantityController.text =
        productsList[index].quantity.toString();
    editProductPriceController.text = productsList[index].price.toString();
    editProductNoteController.text = productsList[index].note;
    editProductRackNumberController.text =
        productsList[index].rackId.toString();
    editProductRackLevelController.text =
        productsList[index].rackLevel.toString();
    selectedBrand.value = productsList[index].brandId.toString();
    selectedDistributor.value = productsList[index].distributorId.toString();
    selectedBrandName.value = productsList[index].brandName;
    selectedDistributorName.value = productsList[index].distributorName;
  }

  editProduct() async {
    final url = "${Environment().api}/product";

    var request = http.MultipartRequest("PUT", Uri.parse(url));

    request.fields["product_id"] = product_id.value.toString();
    request.fields["name"] = editProductNameController.text;
    request.fields["other_name"] = editProductOtherNameController.text;
    request.fields["brand"] = selectedBrand.value;
    request.fields["model"] = editProductModelController.text;
    request.fields["price"] = editProductPriceController.text;
    request.fields["quantity"] = editProductQuantityController.text;
    request.fields["note"] = editProductNoteController.text;
    request.fields["rack_id"] = editProductRackNumberController.text;
    request.fields["rack_level"] = editProductRackLevelController.text;
    request.fields["distributor_id"] = selectedDistributor.value;

    request.headers.addAll({
      'Authorization': 'Bearer ${auth_token}',
      'Accept': 'application/json',
    });

    for (var file in productImages) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile =
          http.MultipartFile('images', stream, length, filename: file.name);
      request.files.add(multipartFile);
    }
    var response = await request.send();

    if (response.statusCode == 200) {
      Get.back();
      showToast('Product edited Successfully');
      productImagesConv.clear();
      productImages.clear();
      editProductNameController.clear();
      editProductOtherNameController.clear();
      editProductOtherNameController.clear();
      editProductQuantityController.clear();
      editDistributorController.clear();
      editProductPriceController.clear();
      editProductNoteController.clear();
      editBrandController.clear();
      editProductModelController.clear();
      editProductRackNumberController.clear();
      editProductRackLevelController.clear();
      selectedBrand.value = '';
      selectedDistributor.value = '';
      selectedBrandName.value = '';
      selectedDistributorName.value = '';
    } else {
      showToast('Product added Failed');
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storemanager/controllers/LoginController.dart';
import 'package:storemanager/controllers/ProductController.dart';
import 'package:storemanager/models/Environment.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final productController = Get.put(ProductController());
  final loginController = Get.put(LoginController());

  var isObscure = true.obs;
  var isLoading = false.obs;
  var isMobile = false.obs;
  var startShopping = false.obs;
  var selectedBrand = ''.obs;
  var selectedDistributor = ''.obs;

  var selectedProductsList = [].obs;
  var brands = [].obs;
  var distributors = [].obs;
  var productImagesConv = <String>[].obs;
  var productImages = <XFile>[].obs;

  var shopName = ''.obs;
  var activeIndex = 0.obs;

  final addProductNameController = TextEditingController();
  final addProductOtherNameController = TextEditingController();
  final addProductModelController = TextEditingController();
  final addProductQuantityController = TextEditingController();
  final addProductPriceController = TextEditingController();
  final addProductNoteController = TextEditingController();
  final addBrandController = TextEditingController();
  final addProductRackNumberController = TextEditingController();
  final addProductRackLevelController = TextEditingController();
  final addDistributorController = TextEditingController();

  @override
  void onInit() {
    shopName.value = 'Ranatunga Motors';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  updateProductQuantity(id, name, quantity, price) {
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

  void _downloadFile(Uint8List data, String fileName) {
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  _downloadAndPrintFile(List<int> data, String fileName) {
    final blob = html.Blob([data], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an invisible <a> element to trigger the download
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();

    // Call JavaScript function to print PDF
    js.context.callMethod('printPdf', [url]);

    // Clean up the object URL after printing
    html.Url.revokeObjectUrl(url);
  }

  sendOrderData() async {
    final url = "${Environment().api}/order/order-bill";
    final response = await http
        .post(Uri.parse(url), body: jsonEncode(selectedProductsList), headers: {
      // 'Accept': 'application/json',
      'Authorization': 'Bearer ${productController.auth_token}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      try {
        final pdfData = response.bodyBytes;

        var now = DateTime.now();
        var formattedDate =
            '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}';

        // _downloadFile(pdfData, 'bill_$formattedDate.pdf');
        await _downloadAndPrintFile(pdfData, 'bill_$formattedDate');
        print('PDF downloaded successfully');
        await js.context.callMethod('printPdf', ['bill_$formattedDate.pdf']);
      } catch (e) {
        print('Error downloading PDF: $e');
      }
    } else {
      print('Failed to download PDF');
    }
  }

  fetchBrands() async {
    final url = "${Environment().api}/product/brands";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Authorization': 'Bearer ${productController.auth_token}',
    });
    var result = jsonDecode(response.body);
    brands.value = result['brands'];
    return (result);
  }

  fetchDistributors() async {
    final url = "${Environment().api}/product/distributors";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Authorization': 'Bearer ${productController.auth_token}',
    });
    var result = jsonDecode(response.body);
    print(result);
    distributors.value = result['distributors'];
    print(distributors);

    return (result);
  }

  Future getProductImages() async {
    final picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      productImages.addAll(pickedFiles);
    } else {
      print('No image selected.');
    }
  }

  //get Quotation from Camera
  Future getProductImagesCamera() async {
    final ImagePicker _picker = ImagePicker();
    final img =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    productImages.add(img!);
  }

  addProduct() async {
    final url = "${Environment().api}/product";

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields["name"] = addProductNameController.text;
    request.fields["other_name"] = addProductOtherNameController.text;
    request.fields["brand"] = selectedBrand.value;
    request.fields["model"] = addProductModelController.text;
    request.fields["price"] = addProductPriceController.text;
    request.fields["quantity"] = addProductQuantityController.text;
    request.fields["note"] = addProductNoteController.text;
    request.fields["rack_id"] = addProductRackNumberController.text;
    request.fields["rack_level"] = addProductRackLevelController.text;
    request.fields["distributor_id"] = selectedDistributor.value;

    request.headers.addAll({
      'Authorization': 'Bearer ${productController.auth_token}',
      'Accept': 'application/json',
    });

    for (var file in productImages) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile =
          http.MultipartFile('images', stream, length, filename: file.name);
      request.files.add(multipartFile);
    }
    print('0000000000000000000000');
    var response = await request.send();
    print('1111111111111111111111');


    if (response.statusCode == 200) {
      Get.back();
      loginController.showToast('Product added Successfully');
      selectedProductsList.clear();
      productImagesConv.clear();
      productImages.clear();
      addProductNameController.clear();
      addProductOtherNameController.clear();
      addProductOtherNameController.clear();
      addProductQuantityController.clear();
      addDistributorController.clear();
      addProductPriceController.clear();
      addProductNoteController.clear();
      addBrandController.clear();
      addProductModelController.clear();
      addProductRackNumberController.clear();
      addProductRackLevelController.clear();
      selectedBrand.value = '';
      selectedDistributor.value = '';
    } else {
      loginController.showToast('Product added Failed');
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storemanager/controllers/ProductController.dart';
import 'package:storemanager/models/Environment.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:js' as js;

class HomeController extends GetxController {
  final productController = Get.put(ProductController());
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

  void _downloadAndPrintFile(List<int> data, String fileName) {
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
        _downloadAndPrintFile(pdfData, 'bill_$formattedDate');
        print('PDF downloaded successfully');
        js.context.callMethod('printPdf', ['bill_$formattedDate.pdf']);
      } catch (e) {
        print('Error downloading PDF: $e');
      }
    } else {
      print('Failed to download PDF');
    }
  }
}

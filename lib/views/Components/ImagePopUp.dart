import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storemanager/controllers/ProductController.dart';

class ImagePopUp extends StatelessWidget {
  ImagePopUp({Key? key}) : super(key: key);
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return AlertDialog(
          content: Image.network(
            productController.selectedImageUrl.value,
            fit: BoxFit.cover,
            width: 1000,
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}

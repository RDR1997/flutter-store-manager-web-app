import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storemanager/controllers/LoginController.dart';

class LoginAlertBox extends StatelessWidget {
  LoginAlertBox({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // Delayed redirection to the previous page
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
      // Get.back(); // Redirecting to the previous page
    });
    return GetX<LoginController>(
        builder: (controller) => AlertDialog(
              title: Text(loginController.loginMassage.value),
              content: const Icon(
                Icons.done_all_rounded,
                color: Colors.green,
                size: 100,
              ),
              actions: <Widget>[],
            ));
  }
}

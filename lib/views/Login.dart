import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Constants.dart';
import '../controllers/LoginController.dart';
import 'Home.dart';

class Login extends StatelessWidget {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return Scaffold(
        // backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
      child: Center(
        child: Container(
            width: Width > 600 ? Width * 0.4 : 400,
            padding: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 20),
            // height: Height,
            // width: Width,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.store_rounded,
                  size: 100,
                  color: colortheam1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Ranatunga Motors',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                      color: titleFontColor),
                ),
                const SizedBox(
                  height: 50,
                ),
                GetX<LoginController>(
                    builder: (controller) => AutofillGroup(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: loginController.emailController,
                                  autofillHints: const [AutofillHints.email],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter user name";
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 158, 158),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 158, 158),
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    labelText: 'User name',
                                    hintText: 'User name',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller:
                                      loginController.passwordController,
                                  autofillHints: const [AutofillHints.password],
                                  obscureText: loginController.isObscure.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 158, 158),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 158, 158),
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    labelText: 'Password',
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(controller.isObscure.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        loginController.toggleObscure();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                const SizedBox(
                  height: 20,
                ),
                GetX<LoginController>(
                  builder: (_) {
                    return SizedBox(
                        child: loginController.isLoading.value
                            ? const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                                width: Width * 0.3,
                                height: Height * 0.06,
                                child: MaterialButton(
                                  onPressed: () async {
                                    loginController.toggleLoading();

                                    await loginController.login(
                                        loginController.emailController.text,
                                        loginController
                                            .passwordController.text);

                                    // Add your login logic here
                                  },
                                  color: colortheam1,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: fontColor),
                                  ),
                                ),
                              ));
                  },
                ),
              ],
            )),
      ),
    ));
  }
}

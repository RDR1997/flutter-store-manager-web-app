import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storemanager/controllers/HomeController.dart';
import 'package:storemanager/controllers/ProductController.dart';
import 'package:searchfield/searchfield.dart';
import 'package:dotted_border/dotted_border.dart';

class AddDistributor extends StatelessWidget {
  AddDistributor({Key? key}) : super(key: key);
  final productController = Get.put(ProductController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;

    return GetBuilder<ProductController>(
      builder: (controller) {
        return AlertDialog(
          title: const Text(
            'Add New Distributor',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
          content: SingleChildScrollView(
            child: Container(
              // height: height * 0.8,
              width: width * 0.7,
              child: Column(
                children: [
                  TextFormField(
                    controller: homeController.addDistributorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is requried';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor("#F6F7FA"),
                        enabled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        labelText: 'Distributor Name',
                        labelStyle:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        hintText: 'Distributor Name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: homeController.addDistributorPhoneNoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number is requried';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor("#F6F7FA"),
                        enabled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        labelText: 'Distributor Phone Number',
                        labelStyle:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        hintText: 'Distributor Phone Number'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: homeController.addDistributorNoteController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor("#F6F7FA"),
                        enabled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        labelText: 'Note',
                        labelStyle:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        hintText: 'Note'),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () {
                    homeController.addDistributorController.clear();
                    homeController.addDistributorPhoneNoController.clear();
                    homeController.addDistributorNoteController.clear();
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () async {
                    await homeController.addDistributor();
                    await homeController.fetchDistributors();
                    homeController.addDistributorController.clear();
                    homeController.addDistributorPhoneNoController.clear();
                    homeController.addDistributorNoteController.clear();
                    Get.back();
                  },
                  child: const Text('Done',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20))),
            )
          ],
        );
      },
    );
  }
}

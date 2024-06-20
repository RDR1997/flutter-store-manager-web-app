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
import 'package:storemanager/views/Components/AddBrand.dart';
import 'package:storemanager/views/Components/AddDistributor.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);
  final productController = Get.put(ProductController());
  final homeController = Get.put(HomeController());
  final _formkey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focusDistributor = FocusNode();
  final ScrollController _scrollController = ScrollController();

  Future<String> _convertXFileToBlobUrl(XFile file) async {
    Uint8List bytes = await file.readAsBytes();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;

    return GetBuilder<ProductController>(
      builder: (controller) {
        return AlertDialog(
          title: const Text(
            'Add New Product',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
          content: SingleChildScrollView(
            child: Container(
                // height: height * 0.8,
                width: width * 0.7,
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text("General:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: HexColor('#e3e4e6'),
                                            width: 1.0)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller: homeController
                                                .addProductNameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Name is requried';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: HexColor("#F6F7FA"),
                                                enabled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                labelText: 'Product Name',
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                                hintText: 'Product Name'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: homeController
                                                .addProductOtherNameController,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: HexColor("#F6F7FA"),
                                                enabled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                labelText: 'Product Other Name',
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                                hintText: 'Product Other Name'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          // TextFormField(
                                          //   controller:
                                          //       homeController.addProductBrandController,
                                          //   validator: (value) {
                                          //     if (value == null || value.isEmpty) {
                                          //       return 'Brand is requried';
                                          //     }
                                          //     return null;
                                          //   },
                                          //   decoration: const InputDecoration(
                                          //       enabled: true,
                                          //       focusedBorder: OutlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: Color.fromARGB(
                                          //                   255, 158, 158, 158),
                                          //               style: BorderStyle.solid)),
                                          //       border: OutlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: Color.fromARGB(
                                          //                   255, 158, 158, 158),
                                          //               style: BorderStyle.solid)),
                                          //       labelText: 'Product Brand',
                                          //       hintText: 'Product Brand'),
                                          // ),

                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 10,
                                                child: Obx(() =>
                                                    SearchField<dynamic>(
                                                      // controller: homeController
                                                      //     .addBrandController,
                                                      focusNode: focus,
                                                      itemHeight: 55,
                                                      searchInputDecoration:
                                                          InputDecoration(
                                                        border:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                7.0),
                                                          ),
                                                        ),
                                                        // suffixIcon: Icon(
                                                        //   Icons.arrow_drop_down,
                                                        //   size: 40,
                                                        // ),

                                                        filled: true,
                                                        fillColor:
                                                            HexColor("#F6F7FA"),
                                                        labelText: "Brand",
                                                        labelStyle:
                                                            const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 18),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical:
                                                              20.0, // Adjust the padding as needed
                                                          horizontal: 16.0,
                                                        ),
                                                      ),
                                                      suggestions:
                                                          homeController.brands
                                                              .map(
                                                                (e) =>
                                                                    SearchFieldListItem<
                                                                        dynamic>(
                                                                  e['name'],

                                                                  item: e,
                                                                  // Use child to show Custom Widgets in the suggestions
                                                                  // defaults to Text widget
                                                                  child: e ==
                                                                          null
                                                                      ? const Text(
                                                                          'data')
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(
                                                                                  e['name'],
                                                                                  softWrap: true,
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.fade,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                ),
                                                              )
                                                              .toList(),
                                                      onSuggestionTap:
                                                          (SearchFieldListItem<
                                                                  dynamic>
                                                              value) {
                                                        homeController
                                                                .selectedBrand
                                                                .value =
                                                            value.item['id']
                                                                .toString();
                                                        print(homeController
                                                            .selectedBrand
                                                            .value);
                                                        // setState(() {
                                                        //   _selectedProject =
                                                        //       value.item.id.toString();
                                                        //   _selectedProject_id =
                                                        //       value.item.project_id.toString();
                                                        // });

                                                        focus.unfocus();
                                                      },
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Brand is requried';
                                                        } else if (homeController
                                                                .selectedBrand
                                                                .value ==
                                                            '') {
                                                          return 'Invalid Brand';
                                                        }
                                                        return null;
                                                      },
                                                    )),
                                              ),
                                              Expanded(
                                                  child: IconButton(
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AddBrand(),
                                                  );
                                                },
                                                icon: const Icon(Icons.add),
                                              ))
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: homeController
                                                .addProductModelController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Model is requried';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: HexColor("#F6F7FA"),
                                                enabled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                labelText: 'Product Model',
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                                hintText: 'Product Model'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: homeController
                                                .addProductPriceController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Price is requried';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: HexColor("#F6F7FA"),
                                                enabled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                labelText: 'Product Price',
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                                hintText: 'Product Price'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: homeController
                                                .addProductQuantityController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Quantity is requried';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: HexColor("#F6F7FA"),
                                                enabled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                labelText: 'Product Quantity',
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                                hintText: 'Product Quantity'),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text("Location:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: HexColor('#e3e4e6'),
                                            width: 1.0)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller: homeController
                                                .addProductRackNumberController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Rack Number';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: HexColor("#F6F7FA"),
                                                enabled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                labelText: 'Rack number',
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                                hintText: 'Rack Number'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: homeController
                                                .addProductRackLevelController,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: HexColor("#F6F7FA"),
                                                enabled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide
                                                      .none, // Remove the border
                                                ),
                                                labelText: 'Rack Level',
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18),
                                                hintText: 'Rack Level'),
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text("Distributor:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: HexColor('#e3e4e6'),
                                            width: 1.0)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: Obx(() => SearchField<dynamic>(
                                                // controller: homeController
                                                //     .addDistributorController,
                                                focusNode: focusDistributor,
                                                itemHeight: 55,
                                                searchInputDecoration:
                                                    InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(7.0),
                                                    ),
                                                  ),
                                                  // suffixIcon: Icon(
                                                  //   Icons.arrow_drop_down,
                                                  //   size: 40,
                                                  // ),

                                                  filled: true,
                                                  fillColor:
                                                      HexColor("#F6F7FA"),
                                                  labelText: "Distributor",
                                                  labelStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical:
                                                        20.0, // Adjust the padding as needed
                                                    horizontal: 16.0,
                                                  ),
                                                ),
                                                suggestions:
                                                    homeController.distributors
                                                        .map(
                                                          (e) =>
                                                              SearchFieldListItem<
                                                                  dynamic>(
                                                            e['name'],

                                                            item: e,
                                                            // Use child to show Custom Widgets in the suggestions
                                                            // defaults to Text widget
                                                            child: e == null
                                                                ? const Text(
                                                                    'data')
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            e['name'],
                                                                            softWrap:
                                                                                true,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.fade,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                          ),
                                                        )
                                                        .toList(),
                                                onSuggestionTap:
                                                    (SearchFieldListItem<
                                                            dynamic>
                                                        value) {
                                                  homeController
                                                          .selectedDistributor
                                                          .value =
                                                      value.item['id']
                                                          .toString();
                                                  print(homeController
                                                      .selectedDistributor
                                                      .value);
                                                  // setState(() {
                                                  //   _selectedProject =
                                                  //       value.item.id.toString();
                                                  //   _selectedProject_id =
                                                  //       value.item.project_id.toString();
                                                  // });

                                                  focus.unfocus();
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Distributor is requried';
                                                  } else if (homeController
                                                          .selectedDistributor
                                                          .value ==
                                                      '') {
                                                    return 'Invalid Distributor';
                                                  }
                                                  return null;
                                                },
                                              )),
                                        ),
                                        Expanded(
                                            child: IconButton(
                                          onPressed: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AddDistributor(),
                                            );
                                          },
                                          icon: const Icon(Icons.add),
                                        ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    minLines:
                                        1, // Normal textInputField will be displayed
                                    maxLines: 3,
                                    controller:
                                        homeController.addProductNoteController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: HexColor("#F6F7FA"),
                                        enabled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide
                                              .none, // Remove the border
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide
                                              .none, // Remove the border
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide
                                              .none, // Remove the border
                                        ),
                                        labelText: 'Note',
                                        labelStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                        hintText: 'Note'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text("Pick Images for Product:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.left),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.all(15),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //       border: Border.all(
                        //           color: HexColor('#e3e4e6'), width: 1.0)),
                        //   // child:
                        // ),
                        Obx(() => Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DottedBorder(
                                dashPattern: const [8, 4],
                                strokeWidth: 2,
                                color: const Color.fromARGB(255, 207, 229, 238),
                                child: homeController.productImages.isNotEmpty
                                    ? Container(
                                        // color: HexColor("B5BFE4"),
                                        width: double.infinity,
                                        // height: 500,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, right: 5),
                                                  child: InkWell(
                                                    onTap: () {
                                                      homeController
                                                          .getProductImagesCamera();
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .linked_camera_outlined,
                                                      color:
                                                          HexColor("#FC5000"),
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 30),
                                                InkWell(
                                                  onTap: () {
                                                    print(
                                                        '111111111111111111111111111111');
                                                    print(homeController
                                                        .productImages);
                                                    print(
                                                        '111111111111111111111111111111');
                                                    homeController
                                                        .getProductImages();
                                                  },
                                                  child: Icon(
                                                    Icons.photo_library,
                                                    color: HexColor("#FC5000"),
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            const Text(
                                              'Select Quotattion (Maximum 50MB)',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            //Display the selected file
                                            homeController
                                                    .productImages.isNotEmpty
                                                ? Column(
                                                    children: [
                                                      const Text(
                                                        "Selected Images",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey)),
                                                          height: height * 0.5,
                                                          width:
                                                              double.infinity,
                                                          // width: 200,
                                                          child:
                                                              CupertinoScrollbar(
                                                            isAlwaysShown: true,
                                                            controller:
                                                                _scrollController,
                                                            child: ListView
                                                                .separated(
                                                              controller:
                                                                  _scrollController,
                                                              itemCount:
                                                                  homeController
                                                                      .productImages
                                                                      .length,
                                                              separatorBuilder:
                                                                  (context,
                                                                      index) {
                                                                return const SizedBox(
                                                                  height: 4,
                                                                );
                                                              },
                                                              // itemCount: homeController.productImages!.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                //return Text(homeController.productImages![index].name);
                                                                print(homeController
                                                                    .productImages);
                                                                final XFile
                                                                    file =
                                                                    homeController
                                                                            .productImages[
                                                                        index];
                                                                return FutureBuilder<
                                                                        String>(
                                                                    future:
                                                                        _convertXFileToBlobUrl(
                                                                            file),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot.connectionState ==
                                                                              ConnectionState
                                                                                  .done &&
                                                                          snapshot
                                                                              .hasData) {
                                                                        return Container(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              SizedBox(height: height * 0.3, width: width * 0.2, child: Image.network(snapshot.data!)),
                                                                              //Text(homeController.productImages![index].name),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  homeController.productImages.removeAt(index);
                                                                                },
                                                                                child: const Icon(Icons.delete),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        );
                                                                      } else if (snapshot
                                                                          .hasError) {
                                                                        return Text(
                                                                            'Error loading image');
                                                                      } else {
                                                                        return CircularProgressIndicator();
                                                                      }
                                                                    });
                                                              },
                                                            ),
                                                          )),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ))
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: DottedBorder(
                                          dashPattern: const [8, 4],
                                          strokeWidth: 2,
                                          color: const Color.fromARGB(
                                              0, 207, 229, 255),
                                          child: Container(
                                              // color: HexColor("B5BFE4"),
                                              width: double.infinity,
                                              // height: height*0.2,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                right: 5),
                                                        child: InkWell(
                                                          onTap: () {
                                                            homeController
                                                                .getProductImagesCamera();
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .linked_camera_outlined,
                                                            color: HexColor(
                                                                "#FC5000"),
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 30),
                                                      InkWell(
                                                        onTap: () {
                                                          homeController
                                                              .getProductImages();
                                                        },
                                                        child: Icon(
                                                          Icons.photo_library,
                                                          color: HexColor(
                                                              "#FC5000"),
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  const Text(
                                                    'Select Quotattion (Maximum 50MB)',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                              ),
                            )),
                      ],
                    ),
                  ),
                )),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () {
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
                    await homeController.addProduct();
                    // Get.back();
                    productController.getProducts();
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

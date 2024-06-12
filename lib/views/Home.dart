import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:storemanager/Constants.dart';
import 'package:storemanager/controllers/HomeController.dart';
import 'package:storemanager/controllers/ProductController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:storemanager/views/Components/ImagePopUp.dart';
import 'package:storemanager/views/Components/Order.dart';
import 'package:storemanager/views/Components/OrderPc.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final homeController = Get.put(HomeController());
  final productController = Get.put(ProductController());
  List<Map<String, dynamic>> data = [];

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<HomeController>(
        builder: (controller) => Scaffold(
              extendBody: true,
              floatingActionButton: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  if (homeController.startShopping.value)
                    FloatingActionButton(
                      onPressed: () {
                        // homeController.toggleStartShopping();
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => OrderPc(),
                        );
                      },
                      child: Icon(Icons.done),
                    ),
                ],
              ),
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: true,
                    expandedHeight: 160.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            homeController.shopName.value,
                            style:
                                TextStyle(fontSize: 50, color: titleFontColor),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  homeController.startShopping.value
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          // width:
                                          //     Width * 0.3,
                                          height: Height * 0.045,
                                          child: MaterialButton(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            onPressed: () async {},
                                            color: colortheam5,
                                            textColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.add_box_outlined,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Add a new Product',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    // width:
                                    //     Width * 0.3,
                                    height: Height * 0.045,
                                    child: MaterialButton(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      onPressed: () async {
                                        homeController.toggleStartShopping();
                                      },
                                      color: homeController.startShopping.value
                                          ? Colors.red
                                          : colortheam2,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                              size: 15,
                                              homeController.startShopping.value
                                                  ? Icons.cancel_outlined
                                                  : Icons
                                                      .add_shopping_cart_rounded),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            homeController.startShopping.value
                                                ? 'Cancel the Order'
                                                : 'Make a Order',
                                            style: TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      background: Image.asset(
                        '/images/coverPic.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                              child: homeController.isMobile.value
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          productController.productsList.length,
                                      itemBuilder: (context, index) => SizedBox(
                                            height: Height * 0.6,
                                            child: Card(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: Width * 0.5,
                                                    child: const Icon(
                                                      Icons
                                                          .shopping_cart_rounded,
                                                      size: 100,
                                                    ),
                                                  ),
                                                  Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          productController
                                                              .productsList[
                                                                  index]
                                                              .name,
                                                          style: const TextStyle(
                                                              fontSize: 40,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        Text(
                                                            '(${productController.productsList[index].otherName})',
                                                            style: const TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                            'Brand: {${productController.productsList[index].brand}}',
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Text(
                                                            'Model: ${productController.productsList[index].model}',
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ]),
                                                ],
                                              ),
                                            ),
                                          ))
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          productController.productsList.length,
                                      itemBuilder: (context, index) {
                                        final controllers = List.generate(
                                            productController
                                                .productsList.length,
                                            (_) => TextEditingController());
                                        final controller = controllers[index];

                                        List<RxString> variables = <RxString>[];
                                        variables = List<RxString>.generate(
                                            productController
                                                .productsList.length,
                                            (_) => '0'.obs);

                                        return SizedBox(
                                          height: Height * 0.42,
                                          // child: Card(
                                          //   elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    // padding:
                                                    //     const EdgeInsets.all(
                                                    //         10),
                                                    width: Width * 0.3,
                                                    child:

                                                        // const Icon(
                                                        //   Icons.shopping_cart_rounded,
                                                        //   size: 100,
                                                        // ),
                                                        // ---------------------------------------------------------------------------
                                                        CarouselSlider.builder(
                                                      options: CarouselOptions(
                                                        height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height,
                                                        autoPlay: false,
                                                        reverse: true,
                                                        viewportFraction: 1,
                                                        enlargeCenterPage:
                                                            false,
                                                        enlargeStrategy:
                                                            CenterPageEnlargeStrategy
                                                                .height,
                                                        autoPlayInterval:
                                                            const Duration(
                                                                seconds: 3),
                                                        onPageChanged: (xindex,
                                                                reason) =>
                                                            homeController
                                                                .activeIndex
                                                                .value = xindex,
                                                      ),
                                                      itemCount:
                                                          productController
                                                              .productsList[
                                                                  index]
                                                              .images
                                                              .length,
                                                      itemBuilder: (context,
                                                          xindex, realIndex) {
                                                        //final urlImage = topimages[index];

                                                        return GestureDetector(
                                                            onTap: () {
                                                              productController
                                                                      .selectedImageUrl
                                                                      .value =
                                                                  productController
                                                                      .productsList[
                                                                          index]
                                                                      .images[
                                                                          xindex]
                                                                      .imageUrl;
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    ImagePopUp(),
                                                              );
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              child:
                                                                  Image.network(
                                                                productController
                                                                    .productsList[
                                                                        index]
                                                                    .images[
                                                                        xindex]
                                                                    .imageUrl,
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 1000,
                                                              ),
                                                            ));
                                                        // : const CircularProgressIndicator();
                                                      },
                                                    )

                                                    // ---------------------------------------------------------------------------
                                                    ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30),
                                                    child: InkWell(
                                                      onTap:
                                                          homeController
                                                                  .startShopping
                                                                  .value
                                                              ? () {
                                                                  print(productController
                                                                      .productsList[
                                                                          index]
                                                                      .id);
                                                                  print(controllers[
                                                                          index]
                                                                      .text);

                                                                  showDialog<
                                                                      int>(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'Number of Items'),
                                                                        content:
                                                                            TextFormField(
                                                                          controller:
                                                                              controllers[index],
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          decoration:
                                                                              InputDecoration(hintText: 'Enter a number'),
                                                                        ),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            child:
                                                                                Text('Cancel'),
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                          ),
                                                                          ElevatedButton(
                                                                            child:
                                                                                Text('Submit'),
                                                                            onPressed:
                                                                                () async {
                                                                              variables[index].value = controllers[index].text;
                                                                              print(variables[index].value);
                                                                              variables[index].value == '' ? variables[index].value = '0' : variables[index].value;

                                                                              await homeController.updateProductQuantity(index, productController.productsList[index].name, int.parse(variables[index].value), productController.productsList[index].price);
                                                                              print(homeController.selectedProductsList);

                                                                              Get.back();
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              : null,
                                                      child: Container(
                                                        // height: Height*0.3,
                                                        width: Width * 0.2,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            border: Border.all(
                                                                color: HexColor(
                                                                    '#e3e4e6'),
                                                                width: 1.0)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child:
                                                              Obx(() => Stack(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .topEnd,
                                                                    children: [
                                                                      homeController
                                                                              .startShopping
                                                                              .value
                                                                          ? variables[index].value == '0'
                                                                              ? const SizedBox.shrink()
                                                                              : ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                                  child: Container(
                                                                                      padding: const EdgeInsets.all(10),
                                                                                      width: 110,
                                                                                      color: Colors.green,
                                                                                      child: Obx(() => Text(
                                                                                            'Selected: ${variables[index].value}',
                                                                                            style: const TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontSize: 15,
                                                                                              fontWeight: FontWeight.w800,
                                                                                            ),
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.fade,
                                                                                          ))),
                                                                                )
                                                                          : const SizedBox.shrink(),
                                                                      Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(children: [
                                                                                  Icon(
                                                                                    Icons.shopping_cart_rounded,
                                                                                    color: colortheam2,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    'In Stock: ${productController.productsList[index].quantity}',
                                                                                    style: TextStyle(
                                                                                      color: fontColor1,
                                                                                      fontSize: 15,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.fade,
                                                                                  ),
                                                                                ]),
                                                                                SizedBox(height: Height*0.01),
                                                                                Text(
                                                                                  productController.productsList[index].name,
                                                                                  style: TextStyle(
                                                                                    color: fontColor2,
                                                                                    fontSize: 25,
                                                                                    fontWeight: FontWeight.w800,
                                                                                  ),
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.fade,
                                                                                ),
                                                                                SizedBox(height: Height * 0.0025),
                                                                                Text(
                                                                                  '(${productController.productsList[index].otherName})',
                                                                                  style: TextStyle(
                                                                                    color: fontColor2,
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.fade,
                                                                                ),
                                                                                SizedBox(height: Height * 0.01),
                                                                                Text(
                                                                                  'Brand: ${productController.productsList[index].brand} ,Model: ${productController.productsList[index].model} ',
                                                                                  style: TextStyle(
                                                                                    color: fontColor1,
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.fade,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  'Rs.${productController.productsList[index].price}',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 50,
                                                                                    fontWeight: FontWeight.w800,
                                                                                  ),
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.fade,
                                                                                ),
                                                                                const Spacer(
                                                                                  flex: 2,
                                                                                ),
                                                                                Container(
                                                                                    // height: Height*0.3,
                                                                                    width: Width * 0.2,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), border: Border.all(color: HexColor('#e3e4e6'), width: 1.0)),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(10),
                                                                                      child: Column(
                                                                                          // mainAxisAlignment: MainAxisAlignment.start,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                const Text("Note:",
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.black,
                                                                                                      fontSize: 14,
                                                                                                      fontWeight: FontWeight.w400,
                                                                                                      fontFamily: 'Poppins',
                                                                                                    ),
                                                                                                    textAlign: TextAlign.left),
                                                                                                IconButton(
                                                                                                  onPressed: () {},
                                                                                                  icon: Icon(
                                                                                                    Icons.note_alt_rounded,
                                                                                                    color: colortheam2,
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(left: 15, top: 10),
                                                                                              child: Text(productController.productsList[index].note,
                                                                                                  style: const TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 14,
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                    fontFamily: 'Poppins',
                                                                                                  ),
                                                                                                  textAlign: TextAlign.justify),
                                                                                            )
                                                                                          ]),
                                                                                    )),
                                                                                // const Spacer(
                                                                                //   flex: 1,
                                                                                // )
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              // width:
                                                                              //     Width * 0.3,
                                                                              height: Height * 0.05,
                                                                              child: MaterialButton(
                                                                                padding: const EdgeInsets.only(left: 20, right: 20),
                                                                                onPressed: () async {},
                                                                                color: colortheam5,
                                                                                textColor: Colors.black,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                                ),
                                                                                child: const Text(
                                                                                  'Click here to generate to bar code',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ],
                                                                  )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ),
                                        );
                                      },
                                    )),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ));
  }
}

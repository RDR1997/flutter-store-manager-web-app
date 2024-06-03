import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:storemanager/Constants.dart';
import 'package:storemanager/controllers/HomeController.dart';
import 'package:storemanager/controllers/ProductController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:storemanager/views/Components/ImagePopUp.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final homeController = Get.put(HomeController());
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<HomeController>(
        builder: (controller) => Scaffold(
              extendBody: true,
              floatingActionButton: ,
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: true,
                    expandedHeight: 160.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(homeController.shopName.value),
                      background: const FlutterLogo(),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Center(
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
                                                    Icons.shopping_cart_rounded,
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
                                                            .productsList[index]
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
                                    itemBuilder: (context, index) => SizedBox(
                                      height: Height * 0.6,
                                      child: Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  width: Width * 0.5,
                                                  child:

                                                      // const Icon(
                                                      //   Icons.shopping_cart_rounded,
                                                      //   size: 100,
                                                      // ),
                                                      // ---------------------------------------------------------------------------
                                                      CarouselSlider.builder(
                                                    options: CarouselOptions(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      autoPlay: false,
                                                      reverse: true,
                                                      viewportFraction: 1,
                                                      enlargeCenterPage: false,
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
                                                    itemCount: productController
                                                        .productsList[index]
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
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                ImagePopUp(),
                                                          );
                                                        },
                                                        child: Image.network(
                                                          productController
                                                              .productsList[
                                                                  index]
                                                              .images[xindex]
                                                              .imageUrl,
                                                          fit: BoxFit.cover,
                                                          width: 1000,
                                                        ),
                                                      );
                                                      // : const CircularProgressIndicator();
                                                    },
                                                  )

                                                  // ---------------------------------------------------------------------------
                                                  ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          productController
                                                              .productsList[
                                                                  index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 40,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                        Text(
                                                          '(${productController.productsList[index].otherName})',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Text(
                                                          'Brand: ${productController.productsList[index].brand}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                        Text(
                                                          'Model: ${productController.productsList[index].model}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Rs.${productController.productsList[index].price}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 80,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                        const Spacer(
                                                          flex: 2,
                                                        ),
                                                        Container(
                                                            // height: Height*0.3,
                                                            width: Width * 0.2,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                border: Border.all(
                                                                    color: HexColor(
                                                                        '#e3e4e6'),
                                                                    width:
                                                                        1.0)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                            "Note:",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: 'Poppins',
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.left),
                                                                        IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon:
                                                                              Icon(
                                                                            Icons.note_alt_rounded,
                                                                            color:
                                                                                colortheam2,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              15,
                                                                          top:
                                                                              10),
                                                                      child: Text(
                                                                          productController
                                                                              .productsList[
                                                                                  index]
                                                                              .note,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.justify),
                                                                    )
                                                                  ]),
                                                            )),
                                                        const Spacer(
                                                          flex: 1,
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart_rounded,
                                                              color:
                                                                  colortheam2,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'In Stock: ${productController.productsList[index].quantity}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .barcode_reader,
                                                              color:
                                                                  colortheam2,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            TextButton(
                                                              onPressed: () {},
                                                              child: const Text(
                                                                'Click here to generate to bar code',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    // const SizedBox(
                                                    //   height: 5,
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storemanager/controllers/HomeController.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<HomeController>(
        builder: (controller) => Scaffold(
              extendBody: true,
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: true,
                    expandedHeight: 160.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(homeController.shopName.value),
                      background: FlutterLogo(),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, bottom: 20, top: 5),
                                child: Container(
                                  color: Colors.amber,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),

              // SingleChildScrollView(
              //   child: SizedBox(
              //     height: Height * 0.78,
              //     child: Padding(
              //         padding: const EdgeInsets.only(
              //             left: 20.0, right: 20, bottom: 20, top: 5),
              //         child: Text(homeController.userName.value)),
              //   ),
              // )
            ));
  }
}

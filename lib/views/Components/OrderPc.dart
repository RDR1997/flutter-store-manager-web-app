import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storemanager/controllers/HomeController.dart';
import 'package:storemanager/controllers/ProductController.dart';

class OrderPc extends StatelessWidget {
  OrderPc({Key? key}) : super(key: key);
  final productController = Get.put(ProductController());
  final homeController = Get.put(HomeController());

  int getTotalSum() {
    return homeController.selectedProductsList.fold(0, (sum, item) {
      final quantity = item['quantity'] ?? 1; // Ensure quantity is not null
      final price = item['price'] ?? 0; // Ensure price is not null
      final discount = item['discount'] ?? 0; // Ensure discount is not null
      return sum + (quantity * price * (100 - discount) / 100) as int;
    });
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
            'New Order',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
          content: Container(
            height: height * 0.8,
            width: width * 0.7,
            child: Column(children: [
              const Divider(thickness: 2),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Unit Price')),
                    DataColumn(label: Text('Unit Discount')), // New column
                    DataColumn(label: Text('Total')),
                  ],
                  rows: homeController.selectedProductsList
                      .map(
                        (item) => DataRow(cells: [
                          DataCell(Text(item['name'])),
                          DataCell(
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: TextEditingController(
                                  text: item['quantity'].toString(),
                                ),
                                keyboardType: TextInputType.number,
                                // onChanged: (value) {
                                //   item['quantity'] = int.tryParse(value) ?? 1;
                                //   productController
                                //       .update(); // Trigger UI update
                                // },
                                onSubmitted: (value) {
                                  item['quantity'] = int.tryParse(value) ?? 1;
                                  productController
                                      .update(); // Trigger UI update
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          DataCell(Text(item['price'].toString())),
                          DataCell(
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: TextEditingController(
                                  text: item['discount'].toString(),
                                ),
                                keyboardType: TextInputType.number,
                                // onChanged: (value) {
                                //   item['discount'] = int.tryParse(value) ?? 0;
                                //   productController
                                //       .update(); // Trigger UI update
                                // },
                                onSubmitted: (value) {
                                  item['discount'] = int.tryParse(value) ?? 0;
                                  productController
                                      .update(); // Trigger UI update
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                              // Text(
                              //   ((item['quantity'] ?? 1) * (item['price'] ?? 0) -
                              //           (item['discount'] ?? 0))
                              //       .toString())
                              Text((((item['quantity'] ?? 1) *
                                          (item['price'] ?? 0) *
                                          (100 - (item['discount'] ?? 0))) /
                                      100)
                                  .toString())),
                        ]),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      int totalSum = getTotalSum();
                      return Text(
                        'Total: $totalSum',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      );
                    }),
                  ],
                ),
              ),
            ]),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Countinue Shopping',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () {},
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

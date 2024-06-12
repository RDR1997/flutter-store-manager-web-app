import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storemanager/controllers/ProductController.dart';

class Order extends StatelessWidget {
  Order({Key? key}) : super(key: key);
  final productController = Get.put(ProductController());

  final List<Map<String, dynamic>> data = [
    {'name': 'Item 1', 'quantity': 1, 'unitPrice': 50},
    {'name': 'Item 2', 'quantity': 1, 'unitPrice': 30},
    {'name': 'Item 3', 'quantity': 1, 'unitPrice': 45},
  ];

  int getTotalSum() {
    return data.fold(0, (sum, item) {
      return sum + (item['quantity'] * item['unitPrice']) as int;
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
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Unit Price')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: data
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
                                onSubmitted: (value) {
                                  item['quantity'] = int.tryParse(value) ?? 1;
                                  productController
                                      .update(); // Trigger UI update
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          DataCell(Text(item['unitPrice'].toString())),
                          DataCell(Text((item['quantity'] * item['unitPrice'])
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
                        style: TextStyle(
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
                  onPressed: () {},
                  child: const Text(
                    'Cancel',
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

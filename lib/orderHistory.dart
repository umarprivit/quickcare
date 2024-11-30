import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/customerInfo.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({Key? key});

  @override
  State<orderHistory> createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  late List<Map<String, dynamic>> orderHistoryList = [];

  @override
  void initState() {
    super.initState();
    // orderHistoryList = [];
    fetchorderHistory(CustomerInfo.customerId);
  }

  void fetchorderHistory(int userID) async {
    try {
      List<Map<String, dynamic>> fetchedorderHistory =
          await RepositorySingleton.instance.fetchOrderHistory(userID);
      setState(() {
        orderHistoryList = fetchedorderHistory;
      });
    } catch (e) {
      print('Error fetching orderHistory data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: buildOrderHistoryList(
          orderHistoryList: orderHistoryList,
          textStyle: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}

Widget buildOrderHistoryList({
  required List<Map<String, dynamic>> orderHistoryList,
  required TextStyle textStyle,
}) {
  return ListView.builder(
    itemCount: orderHistoryList.length,
    itemBuilder: (context, index) {
      final orderHistory = orderHistoryList[index];
      return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(orderHistory['imageUrl'] ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderHistory['name'] ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 220,
                      height: 30,
                      child: Row(
                        children: [
                          Text(
                            '\$${(orderHistory['price'] as double).toStringAsFixed(2)} x ',
                            style: textStyle,
                          ),
                          Text(
                            orderHistory['quantity'].toString(),
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(),
                      child: Text(orderHistory['status'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: (orderHistory['status'] == 'Delivered')
                                  ? Colors.blue
                                  : (orderHistory['status'] == 'Pending')
                                      ? const Color.fromARGB(255, 2, 90, 47)
                                      : Colors.red)),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

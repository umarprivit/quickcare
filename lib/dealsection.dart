// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/classes/placeOrderInfo.dart';
import 'package:pharmacy_store/searchPage.dart';
import 'package:pharmacy_store/myWidgets.dart';
import 'package:pharmacy_store/widgets/ProductListWidget.dart';

class dealsection extends StatefulWidget {
  final String Name;
  final int Id;

  const dealsection({
    Key? key,
    required this.Name,
    required this.Id,
  }) : super(key: key);

  @override
  _dealsectionState createState() => _dealsectionState();
}

class _dealsectionState extends State<dealsection> {
  List<Map<String, dynamic>> productList = [];

  @override
  void initState() {
    super.initState();

    fetchDealProduct(widget.Id);
  }

  void fetchDealProduct(int Id) async {
    try {
      List<Map<String, dynamic>> fetcheddealsproduct =
          await RepositorySingleton.instance.fetchDealProductDealId(Id);
      setState(() {
        productList = fetcheddealsproduct;
      });
    } catch (e) {
      print('Error fetching product data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => searchPage()),
              );
            },
            icon: Icon(Icons.search),
          ),
        ], // Set the app bar title to the category name
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          ProductListWidget(productList: productList, context: context)
        ]), // Display the product list
      ),
    );
  }
}

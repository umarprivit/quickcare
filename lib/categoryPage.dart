// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/classes/placeOrderInfo.dart';
import 'package:pharmacy_store/searchPage.dart';
import 'package:pharmacy_store/myWidgets.dart';
import 'package:pharmacy_store/widgets/ProductListWidget.dart';

class categoryPage extends StatefulWidget {
  final String Name;
  final int Id;

  const categoryPage({
    Key? key,
    required this.Name,
    required this.Id,
  }) : super(key: key);

  @override
  _categoryPageState createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
  List<Map<String, dynamic>> productList = [];

  @override
  void initState() {
    super.initState();
    // Fetch products when the page is initialized
    fetchCategotyProduct(widget.Id);
  }

  void fetchCategotyProduct(int Id) async {
    try {
      List<Map<String, dynamic>> fetchedCategoryproduct =
          await RepositorySingleton.instance.fetchProductsByCategoryId(Id);
      setState(() {
        productList = fetchedCategoryproduct;
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
          ProductListWidget(
            productList: productList,
            context: context,
          )
        ]), // Display the product list
      ),
    );
  }
}

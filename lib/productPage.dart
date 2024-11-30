// ignore_for_file: prefer_const_constructors, use_super_parameters, library_private_types_in_public_api, camel_case_types

import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/searchPage.dart';

class productPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const productPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<productPage> {
  int _quantity = 1;
  bool isPopVisible = false;
  late bool add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['Name'] ?? ""),
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
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.product['poster_img_url'] ?? '',
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product['Name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_quantity > 1) _quantity--;
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text(
                          '$_quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 174, 173, 173),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Price: ${widget.product['price']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.product['description'],
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 32),
              ],
            ),
            (isPopVisible )?
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top:  20 ,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: (add)
                    ? Text(
                        "Item added to cart!",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 31, 31, 31)),
                      )
                    : Text(
                        "First you login your account",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 233, 81, 81)),
                      ),
              ),
            ): Container(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (CustomerInfo.customerId != 0) {
                    RepositorySingleton.instance.addToCart(
                        CustomerInfo.customerId,
                        widget.product['product_id'],
                        _quantity);
                    setState(() {
                      isPopVisible = true;
                      add = true;
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        isPopVisible = false;
                      });
                    });
                  } else {
                    setState(() {
                      isPopVisible = true;
                      add = false;
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        isPopVisible = false;
                      });
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green,
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                // onPressed: () {
                //   placeOrderInfo.productId =  widget.product['product_id'];
                //   placeOrderInfo.unitCost = widget.product["price"];
                //   placeOrderInfo.price = widget.product["price"];
                //   placeOrderInfo.quantity = _quantity;
                //   List<List<dynamic>> productList = [
                //     [
                //       widget.product['Name'],
                //       widget.product['price'],
                //       _quantity,
                //     ],
                //     // Add more products as needed
                //   ];
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => checkOut(
                //               productList: productList,
                //             )),
                //   );
                // },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue,
                  ),
                ),
                onPressed: () {
                  if (CustomerInfo.customerId != 0) {
                   
                  } else {
                    setState(() {
                      isPopVisible = true;
                      add = false;
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        isPopVisible = false;
                      });
                    });
                  }
                },
                child: Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

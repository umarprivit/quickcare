// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/checkOut.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/myWidgets.dart';

class cartPage extends StatefulWidget {
  cartPage({Key? key}) : super(key: key);

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  late List<bool> selectedList;
  List<Map<String, dynamic>> cartList = [];
  @override
  void initState() {
    super.initState();
    if (CustomerInfo.customerId != 0) {
      fetchCartData(CustomerInfo.customerId);
    }
    selectedList = List<bool>.filled(cartList.length, false);
  }

  void fetchCartData(int userID) async {
    try {
      List<Map<String, dynamic>> fetchedCart =
          await RepositorySingleton.instance.fetchaddToCartData(userID);
      setState(() {
        cartList = fetchedCart;
        selectedList = List<bool>.filled(cartList.length, false);
      });
    } catch (e) {
      print('Error fetching addToCart data: $e');
    }
  }

  double calculateTotalCost() {
    double totalCost = 0;
    for (int i = 0; i < cartList.length; i++) {
      if (selectedList[i]) {
        totalCost += cartList[i]['price'] * cartList[i]['quantity'];
      }
    }
    return totalCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: cartList.length,
          itemBuilder: (context, index) {
            final cart = cartList[index];
            return Dismissible(
              onDismissed: (DismissDirection) {
                RepositorySingleton.instance.deleteFromCart(cart["cart_id"]);
                setState(() {
                  fetchCartData(CustomerInfo.customerId);
                });
              },
              key: Key("$index"),
              background: Container(
                decoration: BoxDecoration(color: Colors.green),
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10), // Padding dena
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(12), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Box shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 4, // Blur radius
                      offset: Offset(0, 2), // Offset
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: selectedList[index],
                      onChanged: (value) {
                        setState(() {
                          selectedList[index] = value!;
                        });
                      },
                      activeColor: const Color.fromARGB(255, 27, 28,
                          29), // Change the color of the circular checkbox when it is selected
                      splashRadius: 10, // Customize the splash radius
                      materialTapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // To remove extra padding
                      visualDensity:
                          VisualDensity.compact, // To make the checkbox smaller
                      focusColor: Colors.transparent, // To remove focus color
                      hoverColor: Colors.transparent, // To remove hover color
                      shape: CircleBorder(), // To make the checkbox circular
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                        boxShadow: [
                          // Adding shadow for depth
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(cart['poster_img_url'] ?? ""),
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
                          cart['Name'] ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 270,
                              height: 30,
                              child: Row(
                                children: [
                                  Text(
                                    '\$${(cart['price'] is int ? (cart['price'] as int).toDouble() : cart['price'] as double?)?.toStringAsFixed(2) ?? 'N/A'} x ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${cart['quantity']}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      cart['quantity']++;
                                    });
                                  },
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (cart['quantity'] > 1) {
                                      setState(() {
                                        cart['quantity']--;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.remove),
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 101,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total: \$${calculateTotalCost()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => checkOut()));
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/ShippingPolicyPage.dart';
import 'package:pharmacy_store/TermsConditionsPage.dart';
import 'package:pharmacy_store/cartpage.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/loginPage.dart';
import 'package:pharmacy_store/notificationPage.dart';
import 'package:pharmacy_store/dealsPage.dart';
import 'package:pharmacy_store/homePage.dart';
import 'package:pharmacy_store/orderHistory.dart';
import 'package:pharmacy_store/privacyPolicyPage.dart';
import 'package:pharmacy_store/profilePage.dart';
import 'package:pharmacy_store/refundPolicyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pharmacyStore extends StatefulWidget {
  const pharmacyStore({super.key});

  @override
  State<pharmacyStore> createState() => _pharmacy_storeState();
}

class _pharmacy_storeState extends State<pharmacyStore> {
  final CarouselController carouselController = CarouselController();
  int notificationCount = 2;
  int navIndex = 0;
  bool searchClick = false;
  bool isLoggedIn = false;
  late List<Widget> pages = [];
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      pages = [
        homepage(),
        dealsPage(), //line per error a raha ha
        cartPage(key: UniqueKey()),
        isLoggedIn ? profilePage() : loginPage(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacy'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  notificationCount = 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => notificationPage(),
                    ),
                  );
                },
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 4,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            CustomerInfo.customerId = CustomerInfo.customerId;
            navIndex = index; // Update the navIndex variable
          });
        },
        indicatorColor: Colors.greenAccent,
        selectedIndex: navIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_offer),
            label: 'Deals',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      drawer: Container(
        width: 250,
        height: 550,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: Colors.white),
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(CustomerInfo.name),
                accountEmail: Text(CustomerInfo.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'U',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.local_offer),
                      title: Text(
                        'Deals',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dealsPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.history),
                      title: Text(
                        'Order History',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => orderHistory()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => privacyPolicyPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_back),
                      title: Text(
                        'Return Policy',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => refundPolicyPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.local_shipping),
                      title: Text(
                        'Shipping Policy',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => shippingPolicyPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.library_books),
                      title: Text(
                        'Terms & Service',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsConditionsPage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: navIndex,
        children: pages,
      ),
    );
  }
}

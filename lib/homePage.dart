// ignore_for_file: prefer_const_constructors, unused_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/classes/placeOrderInfo.dart';
import 'package:pharmacy_store/dealsection.dart';
import 'package:pharmacy_store/myWidgets.dart';
import 'package:pharmacy_store/widgets/ProductListWidget.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> DealPosterList = [];
 
  List<Map<String, dynamic>> dealsList = [];
  List<Map<String, dynamic>> categoryList =[]; 
   int sliderIndex = 0;
  @override
  void initState() {
    super.initState();
    fetchCategoryData();
    fetchproductData();
    fetchDealPosterData();
    fetchProductsInAllDeals();
  }


  void fetchDealPosterData() async {
    try {
      List<Map<String, dynamic>> fetcheddealposter =
          await RepositorySingleton.instance.fetchDealImg();
      setState(() {
        DealPosterList = fetcheddealposter;
      });
    } catch (e) {
      print('Error fetching dealposter data: $e');
    }
  }
  void fetchCategoryData() async {
    try {
      List<Map<String, dynamic>> fetchedcategory =
          await RepositorySingleton.instance.fetchCategoryData();
      setState(() {
        categoryList = fetchedcategory;
      });
    } catch (e) {
      print('Error fetching category data: $e');
    }
  }
  void fetchProductsInAllDeals() async {
    try {
      List<Map<String, dynamic>> fetchedProductsInAllDeals =
          await RepositorySingleton.instance.fetchProductsInAllDeals();
      setState(() {
        dealsList = fetchedProductsInAllDeals;
      });
    } catch (e) {
      print('Error fetching category data: $e');
    }
  }
  List<Map<String, dynamic>> ProductsList = [];
  void fetchproductData() async {
    try {
      List<Map<String, dynamic>> fetchedproduct =
          await RepositorySingleton.instance.fetchProductData();
      setState(() {
        ProductsList = fetchedproduct;
      });
    } catch (e) {
      print('Error fetching product data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildSearchWidget(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CarouselSlider.builder(
                      itemCount: DealPosterList.length,
                      options: CarouselOptions(
                        height: 150,
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            sliderIndex = index;
                          });
                        },
                        // Indicator settings
                        enlargeCenterPage: true, // Dots get bigger when active
                        enableInfiniteScroll: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => dealsection(
                                        Name: DealPosterList[index]["d_name"],
                                        Id: DealPosterList[index]["D_id"],
                                      )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(

                                  // DealPosterList[index]['poster_img_url']??
                                   '',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      buildCarouselIndicators(
                          DealPosterList.length, sliderIndex),
                    ],
                  ),
                  SizedBox(height: 5),
                  buildSectionTitle("Category"),
                  SizedBox(height: 10),
                  buildCategorySection(
                      categoryList: categoryList, context: context),
                  SizedBox(height: 20),
                  buildSectionTitle("Deals"),
                  SizedBox(height: 10),
                  ProductListWidget(productList: dealsList, context: context),
                  SizedBox(height: 20),
                  buildSectionTitle("Featured Products"),
                  SizedBox(height: 10),
                  ProductListWidget(productList: ProductsList, context: context),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

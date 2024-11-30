// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/productPage.dart';

class ProductListWidget extends StatefulWidget {
  final List<Map<String, dynamic>> productList;
  final BuildContext context;

  const ProductListWidget({
    Key? key,
    required this.productList,
    required this.context,
  }) : super(key: key);

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  bool isPopVisible = false;
  late bool add;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(widget.context).size.width ~/ 120,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: MediaQuery.of(widget.context).size.width /
                  (MediaQuery.of(widget.context).size.width ~/ 120 * 225),
            ),
            itemCount: widget.productList.length,
            itemBuilder: (context, index) {
              final product = widget.productList[index];
              return SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 255, 247, 247),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productPage(
                                product: product,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 90,
                          width: 110,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(product['poster_img_url'] ?? ""),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (CustomerInfo.customerId != 0) {
                            RepositorySingleton.instance.addToCart(
                                CustomerInfo.customerId, product['product_id'], 1);
                            setState(() {
                              isPopVisible = true;
                              add = true;
                            });
                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                isPopVisible = false;
                              });
                            });
                          }else{
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
                              Color.fromARGB(255, 52, 148, 102)),
                        ),
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            product['Name'] ?? "",
                            style:
                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        ('Rs. ${product["price"]}'),
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 68, 124, 70),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        isPopVisible ?
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: 20 ,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: (add)? Text(
              "Item added to cart!" ,style: TextStyle(color: const Color.fromARGB(255, 31, 31, 31)),): Text("First you login your account",style: TextStyle(color: const Color.fromARGB(255, 233, 81, 81)),),
              
            ),
          ): Container()
        
      ],
    );
  }
}

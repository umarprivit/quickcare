// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharmacy_store/categoryPage.dart';
import 'package:pharmacy_store/dealsection.dart';
import 'package:pharmacy_store/searchPage.dart';

//categoryWidget
Widget buildCategorySection(
    {required List<Map<String, dynamic>> categoryList,
    required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width ~/ 120,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.width ~/ 120 * 160),
      ),
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        final category = categoryList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => categoryPage(
                  Name: category['name'] ?? '',
                  Id: category[
                      "category_id"], 
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 250, 243, 243),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), 
                ),
              ],
            ), 
            child: Container(
              height: 90, 
              width: 112,
              child: Column(
                children: [
                  Container(
                    height: 90,
                    width: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(category['poster_img_url'] ?? ""),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      category["name"] ?? '',
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 14, 
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto', 
                      ),
                    ),
                  )), 
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

// deal widget
Widget buildDealsSection(
    List<Map<String, dynamic>> dealsList, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width ~/ 320,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.width ~/ 320 * 160),
      ),
      itemCount: dealsList.length,
      itemBuilder: (context, index) {
        final deal = dealsList[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the DealsPage and pass the deal ID
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => dealsection(
                        Name: deal["d_name"],
                        Id: deal["D_id"],
                      )),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    deal['poster_img_url'] ?? ""), // Use 'poster_img_url'
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(255, 250, 243, 243),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget buildCarouselIndicators(int itemCount, int currentIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      itemCount,
      (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: (currentIndex == index) ? 24 : 10,
          height: (currentIndex == index) ? 8 : 5.0,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: (currentIndex == index)
                  ? Color.fromARGB(255, 2, 97, 40)
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(5)),
        );
      },
    ),
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  required IconData prefixIcon,
  String? errorText,
  required bool obs,
  TextInputType keyboardType = TextInputType.text,
  ValueChanged<String>? onChanged,
}) {
  return TextFormField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(prefixIcon),
      border: OutlineInputBorder(),
      errorText: errorText,
    ),
    keyboardType: keyboardType,
    obscureText: obs,
  );
}

Widget buildSearchWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => searchPage()),
      );
    },
    child: Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        enabled: false, // Disable text field to prevent typing directly
        decoration: InputDecoration(
          hintText: 'Search', // Add your search hint text here
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.grey[200], // Set the background color
          filled: true, // Ensure the background color is applied
        ),
      ),
    ),
  );
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Open Sans",
        shadows: [
          Shadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
    ),
  );
}

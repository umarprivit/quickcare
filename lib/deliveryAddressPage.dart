// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_import

import 'package:flutter/material.dart';
import 'package:pharmacy_store/classes/placeOrderInfo.dart';
import 'package:pharmacy_store/deliveryAddressPage.dart';

class deliveryAddressPage extends StatefulWidget {
  static String address = '';

  @override
  _deliveryAddressPageState createState() => _deliveryAddressPageState();

  static String getAddress() {
    return address;
  }
}

class _deliveryAddressPageState extends State<deliveryAddressPage> {
  static TextEditingController _streetController = TextEditingController();
  static TextEditingController _houseNumberController = TextEditingController();
  static TextEditingController _cityController = TextEditingController();
  static String _selectedProvince = "Select Province";
  List<String> _provinces = [
    "Select Province",
    "Punjab",
    "Sindh",
    "Khyber Pakhtunkhwa",
    "Balochistan",
    "Gilgit-Baltistan",
    "Azad Jammu & Kashmir"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Your Delivery Address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _streetController,
                decoration: InputDecoration(
                  labelText: "Street",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(255, 247, 245, 245),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _houseNumberController,
                decoration: InputDecoration(
                  labelText: "House Number",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(255, 247, 245, 245),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Province",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(255, 247, 245, 245),
                ),
                value: _selectedProvince,
                onChanged: (newValue) {
                  setState(() {
                    _selectedProvince = newValue!;
                  });
                },
                items:
                    _provinces.map<DropdownMenuItem<String>>((String province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(255, 247, 245, 245),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  placeOrderInfo.street = _streetController.text;
                  placeOrderInfo.houseNo = _houseNumberController.text;
                  placeOrderInfo.city = _cityController.text;
                  placeOrderInfo.province = _selectedProvince;
                  deliveryAddressPage.address =
                      "${_streetController.text}, ${_houseNumberController.text}, ${_cityController.text}, $_selectedProvince";
                  Navigator.pop(context, deliveryAddressPage.address);
                },
                child: Text("Save Address"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

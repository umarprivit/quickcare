// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/loginPage.dart';
import 'package:pharmacy_store/pharmacyStore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilePage extends StatefulWidget {
  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20), // Add padding
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Color.fromARGB(
                        135, 186, 201, 184), // Change avatar background color
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white, // Customize icon color
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    CustomerInfo.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(
                          255, 92, 125, 255), // Change text color
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    CustomerInfo.email,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600], // Adjust text color
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  buildListTile(Icons.person, 'Profile Details', () {
                    // Navigate to profile details screen
                  }),
                  buildListTile(Icons.image, 'Change Profile Picture', () {
                    // Handle change profile picture
                  }),
                  buildListTile(Icons.settings, 'Log Out', () {
                    logout();
                    CustomerInfo.logout();
                    // Navigate to account settings screen
                  }),
                  buildListTile(Icons.help, 'Help & Support', () {
                    // Navigate to help & support screen
                  }),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blueAccent, // Adjust icon color
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87, // Change text color
        ),
      ),
      onTap: onTap as void Function(),
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    prefs.setInt('customerId', 0);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => pharmacyStore(),
      ),
    );
  }
}

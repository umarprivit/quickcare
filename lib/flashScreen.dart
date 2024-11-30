import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/pharmacyStore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class flashScreen extends StatefulWidget {
  @override
  _flashScreenState createState() => _flashScreenState();
}

class _flashScreenState extends State<flashScreen> {
  int _currentIndex = 0;
  Timer? _timer;
  late BuildContext _context; // Instance variable to store context

  final List<IconData> _icons = [
    Icons.healing, // Healing icon
    Icons.medical_services_outlined, // Medical services outlined icon
    Icons.masks, // Masks icon
    Icons.coronavirus, // Coronavirus icon
    Icons.healing, // Healing icon
  ];

  String _loadingText = 'Loading'; // Initial loading text
  int _dotsCount = 0; // Initial dots count

  @override
  void initState() {
    super.initState();
    getCustomerId();
    _timer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _dotsCount =
            (_dotsCount + 1) % 4; // Update dots count every 500 milliseconds
        if (_dotsCount == 0) {
          // Update loading text when dots count reaches 0
          _loadingText = 'Loading';
        } else {
          // Add dots to loading text based on dots count
          _loadingText += '.';
        }

        // Check if it's time to navigate to the next screen
        if (_currentIndex >= _icons.length - 1) {
          timer.cancel();
          Navigator.of(_context)
              .pushReplacement(MaterialPageRoute(builder: (_) {
            return pharmacyStore();
          }));
        } else {
          // Increment the index for the next icon
          _currentIndex++;
        }
      });
    });
  }

  void getCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CustomerInfo.customerId = prefs.getInt('customerId') ??
        0; // Default value if customerId is not found
    if (CustomerInfo.customerId > 0) {
      CustomerInfo(CustomerInfo.customerId);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Colors.white, // Change background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icons[_currentIndex],
              size: 100.0,
              color: Colors.blue, // Customize the color as needed
            ),
            SizedBox(height: 20),
            Text(
              _loadingText, // Display loading text
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Change text color
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}

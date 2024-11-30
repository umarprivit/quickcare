// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pharmacy_store/myWidgets.dart';
import 'package:pharmacy_store/pharmacyStore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  int _currentIndex = 0;
  final List<String> _images = [
    'assets/fristpage1.png', // Replace with your image paths
    'assets/fristpage2.png',
    'assets/fristpage3.png',
  ];
  @override
  void initState() {
    super.initState();
  }

  Future<void> _setFirstLaunchFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: _images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      image,
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 550.0,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: pointer(_currentIndex, _images.length), // Use the function
            // ),
            buildCarouselIndicators(_images.length, _currentIndex),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the home page
                    _setFirstLaunchFlag();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => pharmacyStore()),
                    );
                  },
                  child: Text('Skip'),
                ),
                SizedBox(
                  width: 150,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the next slide
                    if (_currentIndex < _images.length - 1) {
                      setState(() {
                        _currentIndex++;
                      });
                    } else {
                      // Navigate to the home page
                      _setFirstLaunchFlag();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pharmacyStore()));
                    }
                  },
                  child: (_images.length == _currentIndex + 1)
                      ? Text('Start')
                      : Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> pointer(int currentIndex, int imageCount) {
    List<Widget> indicators = [];
    for (int i = 0; i < imageCount; i++) {
      indicators.add(
        Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == i ? Colors.white : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}

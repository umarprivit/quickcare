// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:pharmacy_store/flashScreen.dart';
import 'package:pharmacy_store/homePage.dart';
import 'package:pharmacy_store/pharmacyStore.dart';
import 'package:pharmacy_store/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('first_launch') ?? true;

  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy Store',
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white, // Set scaffold background to white
        // You can customize other theme properties here
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
        // Ensure that the next line is uncommented if you want to use Material 3
        // useMaterial3: true,
      ),
      home: isFirstLaunch ? splashScreen() : flashScreen(),
    );
  }
}

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pharmacy_store/Repository.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/myWidgets.dart';

class dealsPage extends StatefulWidget {
  const dealsPage({Key? key}) : super(key: key);

  @override
  State<dealsPage> createState() => _dealsPageState();
}

class _dealsPageState extends State<dealsPage> {
  List<Map<String, dynamic>> dealList = [];
  // Repository? repository;

  @override
  void initState() {
    super.initState();
    // repository = RepositorySingleton.instance;
    fetchDealData();
  }

  void fetchDealData() async {
    try {
      List<Map<String, dynamic>> fetchedDeals =
          await RepositorySingleton.instance.fetchDealData();
      setState(() {
        dealList = fetchedDeals;
      });
    } catch (e) {
      print('Error fetching Deal data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                // Add other widgets here as needed
                buildSearchWidget(context),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: buildDealsSection(dealList, context),
                ), // Pass dealList instead of dealsList
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';

class notificationPage extends StatefulWidget {
  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  // Sample list of notifications
  List<Map<String, dynamic>> notifications = [];

  void initState() {
    super.initState();
    fetchedNotificationData(1);
  }

  void fetchedNotificationData(int customer_id) async {
    try {
      List<Map<String, dynamic>> fetchedNotification =
          await RepositorySingleton.instance.fetchNotificationData(customer_id);
      setState(() {
        notifications = fetchedNotification;
      });
    } catch (e) {
      print('Error fetching addToCart data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Handle menu item selection here
              print('Selected: $result');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'MarkAllRead',
                child: Text('Mark All as Read'),
              ),
              const PopupMenuItem<String>(
                value: 'DeleteAll',
                child: Text('Delete All'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 255, 243, 243),
                        Color.fromARGB(255, 255, 255, 255),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(8), // Add padding for better spacing
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        notification['type'] ?? '',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification['msg'] ?? '',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification['date'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Text(
                            notification['time'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

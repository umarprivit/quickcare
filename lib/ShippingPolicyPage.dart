import 'package:flutter/material.dart';

class shippingPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Shipping Policy',
              content:
                  'At Quick Care, we aim to provide reliable and efficient shipping services to our customers. Here are the key details of our shipping policy: We offer shipping to [location] for all orders placed on Quick Care. Shipping charges are calculated based on the weight and size of your order. We provide various shipping options to suit your needs, including standard shipping, express shipping, and same-day delivery in select areas.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Shipping Options:',
              content:
                  'We offer shipping to [location] for all orders placed on Quick Care. Shipping charges are calculated based on the weight and size of your order. We provide various shipping options to suit your needs, including standard shipping, express shipping, and same-day delivery in select areas.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Delivery Timeframe:',
              content:
                  'Orders are typically processed and shipped within [number] business days. Delivery times vary depending on your location and the selected shipping method. Please refer to the estimated delivery timeframe provided at checkout for more information.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Tracking:',
              content:
                  'Once your order is shipped, you will receive a shipping confirmation email containing a tracking number. You can use this tracking number to monitor the status of your shipment and estimated delivery date.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'International Shipping:',
              content:
                  'We also offer international shipping to select countries. International shipping charges and delivery times vary depending on the destination. Please note that customs duties and taxes may apply, and customers are responsible for any additional fees imposed by customs authorities.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Contact Information:',
              content:
                  'For inquiries related to shipping, tracking, or delivery, please feel free to contact our customer support team. You can reach us via email at shipping@quickcare.com or by phone at 1-800-123-4567.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            content,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}

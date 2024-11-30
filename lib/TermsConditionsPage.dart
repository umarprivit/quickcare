import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Terms and Conditions',
              content:
                  'Welcome to Quick Care! By accessing and using our app, you agree to comply with these Terms and Conditions. Please read these terms carefully before using our services. If you do not agree with any part of these terms, you may not use our app. You must be at least 18 years old to register for an account on our app. By registering for an account, you confirm that you are of legal age to form a binding contract and that all information you provide is accurate and complete. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Prohibited Activities:',
              content:
                  'When using our app, you agree not to engage in any prohibited activities, including but not limited to: violating any laws or regulations, infringing upon the rights of others, distributing spam or unsolicited messages, attempting to gain unauthorized access to our systems, interfering with the operation of our app, or engaging in any other activity that may harm Quick Care or its users. We reserve the right to suspend or terminate your account and access to our services if you violate these terms or engage in any prohibited activities.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Intellectual Property:',
              content:
                  'All content and materials available on our app, including but not limited to text, graphics, logos, images, and software, are the property of Quick Care or its licensors and are protected by copyright, trademark, and other intellectual property laws. You may not use, reproduce, modify, distribute, or transmit any content or materials from our app without our prior written consent. You agree not to remove, alter, or obscure any copyright, trademark, or other proprietary notices displayed on our app.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Limitation of Liability:',
              content:
                  'In no event shall Quick Care or its affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including but not limited to lost profits, lost revenue, or loss of data, arising out of or in connection with your use of our app or any services provided therein. Our total liability to you for all claims arising from or related to your use of our app shall not exceed the amount paid by you, if any, for accessing our services.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Contact Information:',
              content:
                  'If you have any questions or concerns about these Terms and Conditions, please contact us at contact@quickcare.com. By using our app, you agree to receive communications from us electronically, including but not limited to emails, push notifications, and in-app messages. You acknowledge that all agreements, notices, disclosures, and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing.',
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

import 'package:flutter/material.dart';

class privacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Privacy Policy',
              content:
                  'Welcome to Quick Care! We are committed to safeguarding the privacy of our users. This Privacy Policy explains how we collect, use, and protect your personal information when you use our application. By using our app, you consent to the terms of this Privacy Policy. We may collect personal information such as name, email address, and shipping address when you register or make a purchase on our app. This information helps us to process orders efficiently, personalize your experience, and provide customer support. Your personal information is used to process orders, provide customer support, and enhance your experience with our app. We do not share your information with third parties without your consent. We may also use your information to send promotional emails or newsletters, which you can opt out of at any time.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Data Security:',
              content:
                  'We take the security of your personal information seriously and implement appropriate measures to protect it from unauthorized access, disclosure, alteration, or destruction. Our app uses encryption technology to secure data transmission. We regularly review our security procedures to ensure they are up to date and effective in protecting your information. However, please note that no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security. By using our app, you acknowledge and accept the inherent risks of online communication and transmission of data.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Cookies:',
              content:
                  'We may use cookies to enhance your browsing experience and gather information about how you interact with our app. Cookies are small files stored on your device that allow us to recognize and remember your preferences. We may use both session cookies, which expire when you close your browser, and persistent cookies, which remain on your device for a set period of time or until you delete them. You can choose to accept or decline cookies through your browser settings. However, please note that disabling cookies may affect your ability to access certain features of our app or make purchases. By continuing to use our app, you consent to our use of cookies as described in this Privacy Policy.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Updates to Privacy Policy:',
              content:
                  'We reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated policy on our app. We encourage you to review this policy periodically to stay informed about how we collect, use, and protect your information. Your continued use of our app after any changes to this Privacy Policy will constitute your acceptance of such changes. If you have any questions or concerns about our Privacy Policy or the handling of your personal information, please contact us at privacy@quickcare.com.',
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

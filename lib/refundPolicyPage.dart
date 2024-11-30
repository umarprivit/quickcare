import 'package:flutter/material.dart';

class refundPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refund Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Refund Policy',
              content: '''
At Quick Care, we prioritize customer satisfaction and strive to provide a seamless shopping experience. If you're not completely satisfied with your purchase, we're here to help with our flexible refund policy.

**Eligibility for Refund:**
To be eligible for a refund, the item must be unused and in the same condition as received. It must also be in the original packaging. Certain items such as perishable goods, personalized items, and prescription medications are not eligible for refunds.

**Initiating a Refund:**
To initiate a refund, please contact our customer support team within [number] days of receiving the item. You may be asked to provide proof of purchase and photos of the item if it arrived damaged.

**Refund Process:**
Once your refund request is approved, we will process the refund to the original method of payment within [number] business days. Please note that shipping fees are non-refundable unless the item received is defective or damaged.

''',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Return Process:',
              content: '''
Our return process is designed to be hassle-free and convenient for our customers. Here's a step-by-step guide to initiating a return:

1. Contact Customer Support: Reach out to our customer support team to request a return authorization. You may be asked to provide details about the item and the reason for return.

2. Packaging: Ensure that the item is securely packaged and in its original condition. Include any accessories or documentation that came with the product.

3. Shipping: Ship the item back to us using a trackable shipping service. You will be responsible for the return shipping costs unless the return is due to a mistake on our part.

4. Inspection and Processing: Once we receive the returned item, our team will inspect it to ensure it meets our return eligibility criteria. Upon approval, we will process the refund or exchange accordingly.

''',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Refund Timeline:',
              content: '''
We understand the importance of timely refunds, and we strive to process refunds as quickly as possible. Here's our estimated refund timeline:

- Credit Card: Refunds to credit cards typically take [number] business days to reflect on your account, depending on your bank's processing time.
- PayPal: Refunds to PayPal accounts are usually processed within [number] business days.
- Store Credit: If you opted for store credit, the refund will be available in your account immediately upon approval.

Please note that refund processing times may vary depending on external factors such as bank processing times and holidays.

''',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Shipping Charges:',
              content: '''
Shipping charges play a crucial role in ensuring your order reaches you safely and on time. Here's our policy regarding shipping charges:

- Non-Refundable: In most cases, shipping charges are non-refundable. However, if the return is due to an error on our part or if the item received is defective or damaged, we will gladly cover the return shipping costs.

- Free Shipping: If your original order qualified for free shipping and the returned item affects the order total, resulting in no longer meeting the free shipping threshold, the standard shipping fee will be deducted from your refund.

''',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              title: 'Contact Information:',
              content: '''
For any inquiries or assistance regarding our refund policy, please don't hesitate to contact our customer support team. You can reach us via:

- Email: support@quickcare.com
- Phone: 1-800-123-4567
- Live Chat: Visit our website to chat with a customer support representative in real-time.

Our dedicated team is here to address your concerns and ensure a positive shopping experience with Quick Care.

''',
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

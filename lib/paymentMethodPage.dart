import 'package:flutter/material.dart';
import 'package:pharmacy_store/classes/placeOrderInfo.dart';

class paymentMethodPage extends StatefulWidget {
  @override
  _paymentMethodPageState createState() => _paymentMethodPageState();
}

class _paymentMethodPageState extends State<paymentMethodPage> {
  static String _selectedPaymentMethod = "Select Payment Method";
  List<String> _paymentMethods = [
    "Credit Card & Debit Card",
    "EasyPaisa",
    "JazzCash",
    "Cash on Delivery"
  ];
  Map<String, IconData> _paymentIcons = {
    "Credit Card & Debit Card": Icons.credit_card,
    "EasyPaisa": Icons.attach_money,
    "JazzCash": Icons.account_balance_wallet,
    "Cash on Delivery": Icons.money_off
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Your Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              _buildPaymentMethodOptions(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_selectedPaymentMethod != "Select Payment Method") {
                    placeOrderInfo.paymentMethod = _selectedPaymentMethod;
                    Navigator.pop(context, _selectedPaymentMethod);
                  } else {
                    // Show error message if no payment method is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select a payment method"),
                      ),
                    );
                  }
                },
                child: Text("Save Payment Method"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _paymentMethods.map((method) {
        return RadioListTile(
          title: Row(
            children: [
              Icon(_paymentIcons[method]), // Icon for the payment method
              SizedBox(width: 10), // Add some spacing between the icon and text
              Text(method), // Payment method name
            ],
          ),
          value: method,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value.toString();
            });
          },
        );
      }).toList(),
    );
  }
}

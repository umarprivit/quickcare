import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final String image;
  final String name;
  final String value;
  final String? selectedPaymentMethod;
  final Function(dynamic) ontap;

  const PaymentOption(
      {super.key,
      required this.value,
      required this.image,
      required this.name,
      required this.selectedPaymentMethod,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
        title: Row(
          children: [
            Image.asset(
              "assets/additional_icons/$image",
              scale: 11,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(name)
          ],
        ),
        value: value,
        groupValue: selectedPaymentMethod,
        onChanged: ontap);
  }
}

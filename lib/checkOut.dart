import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/classes/placeOrderInfo.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/deliveryAddressPage.dart';
import 'package:pharmacy_store/paymentMethodPage.dart';

class checkOut extends StatefulWidget {
  final List<List<dynamic>> productList;

  const checkOut({Key? key, required this.productList}) : super(key: key);

  @override
  State<checkOut> createState() => _checkOutState();
}

class _checkOutState extends State<checkOut> {
  // late int productId = 1;

  int calculateSubtotal() {
    int subtotal = 0;
    for (dynamic item in widget.productList) {
      // productId += item[3];
      if (item is List<dynamic>) {
        // If item is a list (1D or 2D list)
        if (item.length >= 3) {
          // Extract quantity and price and convert them to integers
          int quantity =
              item[1] ?? 0; // Assuming quantity is the second element
          int price = item[2] ?? 0; // Assuming price is the third element
          // Check if quantity and price are valid numeric types
          if (quantity > 0 && price > 0) {
            subtotal += price * quantity;
          }
        }
      }
    }
    placeOrderInfo.amount = subtotal as int;
    return subtotal;
  }

  int calculateTotal() {
    int subtotal = calculateSubtotal();
    int delivery = 0; // Implement delivery cost calculation if needed
    int taxes = subtotal * 0; // Assuming 5% tax rate
    return subtotal + delivery + taxes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => deliveryAddressPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "C/105 : House No 233 Street No 2, Texas, USA",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => paymentMethodPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Easypaisa (0234-2223234)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: Color.fromARGB(255, 127, 133, 127),
              thickness: 1.5,
              height: 30,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                Text(
                  "Rs.${calculateSubtotal()}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery",
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                Text(
                  "Rs.0",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Taxes",
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                Text(
                  "2%",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: Color.fromARGB(255, 120, 133, 120),
              thickness: 1.5,
              height: 30,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                Text(
                  "Rs.${calculateTotal()}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            // Iterate over the product list to place order for each item
            for (dynamic item in widget.productList) {
              String address = deliveryAddressPage.getAddress();
              if (item is List<dynamic> && item.length >= 3) {
                String productName = item[0];
                int quantity = item[1];
                double price = item[2];
                String p_id = item[3];
                // Call placeOrder function for each item

                RepositorySingleton.instance.placeOrder(
                  street: address[0],
                  houseNo: address[1],
                  city: address[2],
                  postalCode: address[3],
                  province: address[3],
                  customerId: CustomerInfo.customerId,
                  quantity: quantity,
                  price: placeOrderInfo.price,
                  productId: placeOrderInfo.productId,
                  orderStatus: placeOrderInfo.orderStatus,
                  unitCost: placeOrderInfo.unitCost,
                  paymentDate: placeOrderInfo.paymentDate,
                  amount: placeOrderInfo.amount,
                  paymentMethod: placeOrderInfo.paymentMethod,
                );

                RepositorySingleton.instance.addNotification(
                  CustomerInfo.customerId,
                  productName,
                  quantity,
                  CustomerInfo.name,
                );
              }
            }
          },
          child: Text(
            'Place Order',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
          ),
        ),
      ),
    );
  }
}

import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/customerInfo.dart';

class placeOrderInfo {
  static var street = "";
  static var houseNo = '';
  static var city = "";
  static var postalCode = 0;
  static var province = '';
  static var customerId = CustomerInfo.customerId;
  static var quantity = 0;
  static var price = 0;
  static var productId = 0;
  static var orderStatus = 'Pending';
  static var unitCost = 0;
  static var paymentDate = "2025-04-04";
  static var amount = 0;
  static var paymentMethod = 'Cash On Delivery';
}

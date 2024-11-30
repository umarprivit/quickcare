import 'package:pharmacy_store/RepositorySingleton.dart';

class CustomerInfo {
  static int customerId = 0;
  static String name = "NAME";
  static String email = "Email@gmail.com";
  static String contact = "0300000000";
  static String password = "";

  CustomerInfo(int customerId) {
    fetchCustomerList(customerId);
  }
  static void logout() {
    customerId = 0;
    name = "NAME";
    email = "Email@gmail.com";
    contact = "0300000000";
    password = "";
  }

  Future<void> fetchCustomerList(int customerID) async {
    try {
      Map<String, dynamic> fetchedCustomerData =
          await RepositorySingleton.instance.fetchCustomerData(customerID);

      // Assign fetched data to instance variables
      customerId = fetchedCustomerData['customer_id'];
      name = fetchedCustomerData['name'];
      email = fetchedCustomerData['email'];
      contact = fetchedCustomerData['contact'];
      password = fetchedCustomerData['password'];
    } catch (e) {
      print('Error fetching customer data: $e');
    }
  }
}

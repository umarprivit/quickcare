
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacy_store/classes/placeOrderInfo.dart';

class Repository {
  final String baseUrl;

  // Private constructor
  Repository._(this.baseUrl);

  // Singleton instance
  static final Repository _instance =
      // Repository._('https://1bb3-39-61-212-238.ngrok-free.app');
      Repository._('http://localhost:3000');
      // Repository._('https://d213-121-52-154-73.ngrok-free.app');

  // Factory constructor to return the singleton instance
  factory Repository() {
    return _instance;
  } // Constructor accepting baseUrl parameter

  Future<List<Map<String, dynamic>>> fetchCategoryData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Category'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch category data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching category data: $e');
      throw Exception('Error fetching category data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDealData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Deals'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch deal data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deal data: $e');
      throw Exception('Error fetching deal data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch product data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product data: $e');
      throw Exception('Error fetching product data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDealImg() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/deal/img-id'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch deal data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deal Img: $e');
      throw Exception('Error fetching deal Img: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchaddToCartData(int userID) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/addToCart/$userID'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch addToCart data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching addToCart data: $e');
      throw Exception('Error fetching addToCart data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchNotificationData(
      int customer_id) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/notification/$customer_id'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch deal data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deal data: $e');
      throw Exception('Error fetching deal data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchSearchData(String search) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/search/$search'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch deal data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deal data: $e');
      throw Exception('Error fetching deal data: $e');
    }
  }

  //method for adding items to the cart;
  Future<Map<String, dynamic>> addToCart(
      int customerId, int productId, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/addToCart'),
        body: json.encode({
          'customerId': customerId,
          'productId': productId,
          'quantity': quantity,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return jsonData; // assuming your response contains itemId and message
      } else {
        throw Exception(
            'Failed to add item to cart. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding item to cart: $e');
      throw Exception('Error adding item to cart: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductsInAllDeals() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products-in-all-deals'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch products in all deals. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products in all deals: $e');
      throw Exception('Error fetching products in all deals: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductsForDeal(int dealId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/deals/$dealId/products'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch products for deal $dealId. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products for deal $dealId: $e');
      throw Exception('Error fetching products for deal $dealId: $e');
    }
  }

  Future<Map<String, dynamic>> sendEmail(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/email'),
        body: json.encode({'email': email, 'otp': otp}),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to send email. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending email: $e');
      throw Exception('Error sending email: $e');
    }
  }

  Future<int> createCustomer(
      String name, String email, String password, String contactInfo) async {
    try {
      // Make POST request to the server's customer endpoint
      final response = await http.post(
        Uri.parse('$baseUrl/customer'), // Replace with your server URL
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'contact_info': contactInfo,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Customer added successfully, parse the response JSON
        final responseData = jsonDecode(response.body);
        int customerId = responseData['customerId'];
        return customerId; // Return the auto-generated customer ID
      } else {
        // Handle other status codes
        throw Exception(
            'Failed to add customer. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error creating customer: $e');
      throw Exception('Error creating customer: $e');
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      // Make a POST request to the server's emailcheck endpoint
      final response = await http.post(
        Uri.parse('$baseUrl/emailcheck'), // Replace with your server URL
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        final responseData = jsonDecode(response.body);
        return responseData['existing'];
      } else {
        // Handle other status codes
        throw Exception(
            'Failed to check email existence. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error checking email existence: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      // Server URL kahan par hai, usko yaha pe set karein
      final String apiUrl =
          '$baseUrl/login'; // Apne server ka URL yaha set karein

      // Request body banao
      final Map<String, dynamic> requestData = {
        'email': email,
        'password': password,
      };

      // Server ko POST request bhejo
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      // Response status code ko check karo
      if (response.statusCode == 200) {
        // Response JSON ko parse karo
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // Return karo response data (message aur user details)
        return responseData;
      } else {
        // Agar response successful nahi hai, to exception throw karo error message ke saath
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      // Agar kisi bhi tarah ka error aata hai, to exception throw karo error message ke saath
      throw Exception('Error logging in: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCustomerData(int customerId) async {
    final url = Uri.parse('$baseUrl/customer/$customerId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load customer data');
    }
  }

  Future<void> deleteFromCart(int cartId) async {
    final url = Uri.parse('$baseUrl/deleteFromCart/$cartId');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print('Item deleted from cart successfully');
      } else {
        print('Failed to delete item from cart: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error deleting item from cart: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductsByCategoryId(
      int categoryId) async {
    // Replace 'your_base_url' with your actual base URL
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products/$categoryId'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch product data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products for category $categoryId: $e');
      throw Exception('Error fetching products for category $categoryId: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDealProductDealId(int dealId) async {
    // Replace 'your_base_url' with your actual base URL
    try {
      final response = await http.get(Uri.parse('$baseUrl/deals/$dealId'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(jsonData);
        } else {
          throw Exception('Unexpected response format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch product data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products for deal $dealId: $e');
      throw Exception('Error fetching products for deal $dealId: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchOrderHistory(int customerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/orderHistory/$customerId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        return List<Map<String, dynamic>>.from(jsonData);
      } else {
        throw Exception('Unexpected response format: $jsonData');
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load order history');
    }
  }

  Future<void> placeOrder({
    required String street,
    required String houseNo,
    required String city,
    required String postalCode,
    required String province,
    required int customerId,
    required int quantity,
    required int price,
    required int productId,
    required String orderStatus,
    required int unitCost,
    required String paymentDate,
    required int amount,
    required String paymentMethod,
  }) async {
    final url = Uri.parse('$baseUrl/placeorder');
    final currentDate = DateTime.now();
    final formattedDate =
        '${currentDate.year}-${currentDate.month}-${currentDate.day}';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'street': placeOrderInfo.street,
          'house_no': placeOrderInfo.houseNo,
          'city': placeOrderInfo.city,
          'postal_code': placeOrderInfo.postalCode,
          'province': placeOrderInfo.province,
          'customer_id': placeOrderInfo.customerId,
          'quantity': placeOrderInfo.quantity,
          'price': placeOrderInfo.price,
          'product_id': placeOrderInfo.productId,
          'order_status': placeOrderInfo.orderStatus,
          'unit_cost': placeOrderInfo.unitCost,
          'payment_date': paymentDate,
          'amount': amount,
          'payment_method': paymentMethod,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print('Order placed successfully');
      } else {
        print('Failed to place order: ${response.statusCode}');
      }
    } catch (error) {
      print('Error placing order: $error');
    }
  }

  Future<void> addNotification(int recipientCustomerId, String productName,
      int quantity, String customerName) async {
    Map<String, dynamic> requestBody = {
      'recipient_customer_id': recipientCustomerId,
      'productname': productName,
      'quantity': quantity,
      'customername': customerName,
    };
    try {
      final url = Uri.parse('$baseUrl/addnotification');
      final response = await http.post(
        Uri.parse(url as String),
        body: requestBody,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Notification added successfully');
      } else {
        print('Failed to add notification: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding notification: $error');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/flashScreen.dart';
import 'package:pharmacy_store/myWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class createAccountPage extends StatefulWidget {
  const createAccountPage({Key? key}) : super(key: key);

  @override
  State<createAccountPage> createState() => _createAccountPageState();
}

class _createAccountPageState extends State<createAccountPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? usernameError;
  String? contactError;
  String? passwordError;
  String? confirmPasswordError;

  void updateLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_add,
                  size: 100,
                  color: Colors.blue,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _usernameController,
                  onChanged: (_) => _validateUsername(),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    errorText: usernameError,
                  ),
                ),
                SizedBox(height: 10),
                buildTextField(
                  controller: _contactController,
                  labelText: 'Contact',
                  prefixIcon: Icons.phone,
                  errorText: contactError,
                  onChanged: (_) => _validatePassword(),
                  obs: false,
                ),
                SizedBox(height: 10),
                buildTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    errorText: passwordError,
                    onChanged: (_) => _validatePassword(),
                    obs: true),
                SizedBox(height: 10),
                buildTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    errorText: confirmPasswordError,
                    onChanged: (_) => _validateConfirmPassword(),
                    obs: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      updateLoginStatus(true);
                      CustomerInfo.name = _usernameController.text;
                      CustomerInfo.password = _passwordController.text;
                      CustomerInfo.contact = _contactController.text;
                      addCustomer();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => flashScreen(),
                        ),
                      );
                    }
                  },
                  child: Text('Next'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the login page
                  },
                  child: Text('Already have an account? Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    return _validateUsername() &&
        _validatePassword() &&
        _validateConfirmPassword() &&
        _validateContact();
  }

  bool _validateUsername() {
    String username = _usernameController.text;
    if (username.isEmpty) {
      setState(() {
        usernameError = 'Username is required';
      });
      return false;
    }
    setState(() {
      usernameError = null;
    });
    return true;
  }

  bool _validatePassword() {
    String password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        passwordError = 'Password is required';
      });
      return false;
    } else if (password.length < 8) {
      // Check if password length is less than 8
      setState(() {
        passwordError = 'Password must be at least 8 characters';
      });
      return false;
    }
    setState(() {
      passwordError = null;
    });
    return true;
  }

  bool _validateConfirmPassword() {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordError = 'Confirm Password is required';
      });
      return false;
    } else if (confirmPassword != password) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
      return false;
    }
    setState(() {
      confirmPasswordError = null;
    });
    return true;
  }

  bool _validateContact() {
    String contact = _contactController.text;
    // Regular expression pattern to match a typical phone number format
    RegExp phoneRegex =
        RegExp(r'^\d{11}$'); // Assuming a 10-digit phone number format

    if (contact.isEmpty) {
      setState(() {
        contactError = 'Contact information is required';
      });
      return false;
    } else if (!phoneRegex.hasMatch(contact)) {
      // Check if the input matches the phone number pattern
      setState(() {
        contactError = 'Invalid phone number format';
      });
      return false;
    }
    setState(() {
      contactError = null;
    });
    return true;
  }

  void addCustomer() async {
    try {
      // Call the createCustomer method to add a new customer
      int customerId = await RepositorySingleton.instance.createCustomer(
        CustomerInfo.name,
        CustomerInfo.email,
        CustomerInfo.password,
        CustomerInfo.contact,
      );

      // Save the customer ID in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('customerId', customerId);

      // Handle the auto-generated customer ID
      print('Customer added successfully. Customer ID: $customerId');

      // Now you can proceed with any additional logic based on the customer ID
    } catch (e) {
      // Handle any errors that occur during the operation
      print('Error adding customer: $e');
      // You can display an error message to the user or handle the error in any other way
    }
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/customerInfo.dart';
import 'package:pharmacy_store/flashScreen.dart';
import 'package:pharmacy_store/forgetPasswordPage.dart';
import 'package:pharmacy_store/signupPage.dart';
import 'package:pharmacy_store/myWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool isCorrect = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/pharmacyIcon.png',
                  height: 150,
                ),
                SizedBox(height: 30),
                buildTextField(
                    controller: emailController,
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    errorText: emailError,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => _validateEmailInputs(),
                    obs: false),
                SizedBox(height: 10),
                buildTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    errorText: passwordError,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (_) => _validatePasswordInputs(),
                    obs: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Validate email and password inputs
                    _validateInputs();

                    // If email and password are valid, proceed with login
                    if (emailError == null && passwordError == null) {
                      handleLogin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => signupPage()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => forgetPasswordPage()),
                    );
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateEmailInputs() {
    setState(() {
      emailError = _validateEmail(emailController.text);
    });
  }

  void _validatePasswordInputs() {
    setState(() {
      passwordError = _validatePassword(passwordController.text);
    });
  }

  void _validateInputs() {
    setState(() {
      emailError = _validateEmail(emailController.text);
      passwordError = _validatePassword(passwordController.text);
    });
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    // Regex for email validation
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password is too short';
    }
    if (value.length > 20) {
      return 'Password is too long';
    }
    return null;
  }

  void handleLogin() async {
    // Example email and password
    String email = emailController.text;
    String password = passwordController.text;

    try {
      // Call loginUser method
      Map<String, dynamic> response =
          await RepositorySingleton.instance.loginUser(email, password);

      // Check if login was successful
      if (response['match']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        prefs.setInt('customerId', response['userId']);
        // print(response['userId']);
        // print('Login successful');
        CustomerInfo(response['userId']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => flashScreen(),
          ),
        );
        // Navigate to next page or perform other actions
      } else {
        setState(() {
          emailController.clear();
          passwordController.clear();
          emailError = "Invalid email";
          passwordError = "Invalid password";
        });
        print('Invalid email or password');
        // Handle invalid credentials
      }
    } catch (error) {
      print('Error logging in: $error');
      // Handle error
    }
  }

// Now you can call the handleLogin function wherever you need to trigger the login process, such as on a button press event.
}

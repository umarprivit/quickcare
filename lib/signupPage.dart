import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/createAccountPage.dart';
import 'package:pharmacy_store/customerInfo.dart';

class signupPage extends StatefulWidget {
  const signupPage({Key? key}) : super(key: key);

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  String? emailError;
  String? codeError;
  late bool isSigningUp;
  late String Otp;
  late bool registeredEmail;

  @override
  void initState() {
    super.initState();
    isSigningUp = true;
  }

  String generateRandomNumber() {
    Random random = Random();
    dynamic otp = (random.nextInt(9999) % 1000) + 1000;
    otp = otp.toString();
    return otp; // Generates a random number between 1000 and 9999
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSigningUp = true;
                    });
                  },
                  // ignore: prefer_const_constructors
                  child: Icon(
                    Icons.email,
                    size: 100,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  onChanged: (_) => _validateEmail(),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    errorText: emailError,
                    enabled: (isSigningUp) ? true : false,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                if (isSigningUp) ...[
                  ElevatedButton(
                    onPressed: () {
                      _validateEmail();
                      // _handleEmailCheck(_emailController.text);
                      if (_emailController.text.isNotEmpty &&
                          emailError == null &&
                          !registeredEmail) {
                        // Proceed to user registration

                        setState(() {
                          Otp = generateRandomNumber();
                          RepositorySingleton.instance
                              .sendEmail(_emailController.text, Otp);
                          isSigningUp = false;
                        });
                      }
                    },
                    child: Text('Next'),
                  )
                ] else ...[
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _codeController,
                    onChanged: (_) => _validateCode(),
                    decoration: InputDecoration(
                      labelText: 'Verification Code',
                      prefixIcon: Icon(Icons.code),
                      border: OutlineInputBorder(),
                      errorText: codeError,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_validateCode()) {
                        CustomerInfo.email = _emailController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => createAccountPage()),
                        );
                      }
                    },
                    child: Text('Verify'),
                  ),
                ],
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

  bool _validateEmail() {
    String email = _emailController.text;

    if (email.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
      return false;
    } else {
      String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(emailPattern);
      if (!regExp.hasMatch(email)) {
        setState(() {
          emailError = 'Enter a valid email';
        });
        return false;
      }
    }
    _handleEmailCheck(_emailController.text);
    setState(() {
      emailError = null;
    });
    return true;
  }

  bool _validateCode() {
    String code = _codeController.text;
    if (code.isEmpty) {
      setState(() {
        codeError = 'Verification code is required';
      });
      return false;
    } else if (code.length != 4) {
      setState(() {
        codeError = 'Verification code must be 4 digits';
      });
      return false;
    } else if (code == Otp) {
      setState(() {
        codeError = null;
      });
      return true;
    }
    return false;
  }

  void _handleEmailCheck(String email) async {
    bool emailExists =
        await RepositorySingleton.instance.checkEmailExists(email);
    if (emailExists) {
      // Email already exists, show error message to the user
      setState(() {
        emailError = 'Email is already registered';
        registeredEmail = true;
      });
    } else {
      // Email does not exist, proceed with user registration
      setState(() {
        emailError = null;
        registeredEmail = false;
        // Proceed with user registration
      });
    }
  }
}

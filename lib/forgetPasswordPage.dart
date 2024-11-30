import 'package:flutter/material.dart';

class forgetPasswordPage extends StatefulWidget {
  const forgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<forgetPasswordPage> createState() => _forgetPasswordPageState();
}

class _forgetPasswordPageState extends State<forgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Recovery'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter your email address to reset your password',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement password recovery logic
                },
                child: Text('Send Reset Instructions'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

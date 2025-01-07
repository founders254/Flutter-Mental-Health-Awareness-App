import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late double deviceHeight, deviceWidth;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to Calm',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Your journey to peace begins here',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: deviceHeight * 0.03),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please input your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: deviceHeight * 0.03),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please input your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: deviceHeight * 0.03),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please input your password';
                  }
                  if (value.length < 8) {
                    return 'Password must have at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: deviceHeight * 0.03),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      Navigator.pushReplacementNamed(context, '/login_screen');
                    } on FirebaseAuthException catch (e) {
                      String errorMessage;
                      if (e.code == 'weak-password') {
                        errorMessage = 'Your password is too weak';
                      } else if (e.code == 'email-already-in-use') {
                        errorMessage = 'Email already exists';
                      } else {
                        errorMessage =
                            'An error occurred. Please try again later.';
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Register'),
              ),
              SizedBox(height: deviceHeight * 0.03),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login_screen');
                },
                child: const Text('Already have an account? Login Here'),
              ),
              SizedBox(height: deviceHeight * 0.03),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/therapist_registration_screen');
                },
                child: const Text('Are you a Therapist? Register Here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

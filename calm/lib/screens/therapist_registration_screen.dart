import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TherapistRegistrationScreen extends StatefulWidget {
  @override
  _TherapistRegistrationScreenState createState() => _TherapistRegistrationScreenState();
}

class _TherapistRegistrationScreenState extends State<TherapistRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Form fields
  String? name, specialization, email, phone;
  double? consultationFee, experience;

  Future<void> _registerTherapist() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Register therapist user
        final user = await _auth.createUserWithEmailAndPassword(
          email: email!,
          password: "DefaultPassword123", // Ask them to change later
        );

        // Save profile to Firestore
        await _firestore.collection('therapists').doc(user.user!.uid).set({
          'name': name,
          'specialization': specialization,
          'email': email,
          'phone': phone,
          'consultationFee': consultationFee,
          'experience': experience,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration successful!'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Therapist Registration')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value,
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Specialization'),
                onSaved: (value) => specialization = value,
                validator: (value) => value!.isEmpty ? 'Enter specialization' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value,
                validator: (value) => value!.isEmpty ? 'Enter email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) => phone = value,
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Consultation Fee (USD)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => consultationFee = double.tryParse(value!),
                validator: (value) => value!.isEmpty ? 'Enter consultation fee' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Experience (Years)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => experience = double.tryParse(value!),
                validator: (value) => value!.isEmpty ? 'Enter years of experience' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerTherapist,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

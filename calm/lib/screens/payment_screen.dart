import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatelessWidget {
  final String appointmentId;
  final double consultationFee;

  PaymentScreen({required this.appointmentId, required this.consultationFee});

  Future<void> _processPayment(BuildContext context) async {
    final appOwnerPercentage = consultationFee * 0.05;
    final therapistPayment = consultationFee - appOwnerPercentage;

    try {
      // Simulating payment logic (replace with actual payment API integration)
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay for payment processing

      // Update Firestore
      await FirebaseFirestore.instance.collection('appointments').doc(appointmentId).update({
        'paymentStatus': 'Paid',
        'appOwnerEarnings': appOwnerPercentage,
        'therapistEarnings': therapistPayment,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful!')),
      );

      Navigator.pop(context); // Return to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _processPayment(context),
          child: Text('Pay \$${consultationFee.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.error, super.key});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your error screen UI
      body: Center(
        child: Text('An error occurred: $error'),
      ),
    );
  }
}

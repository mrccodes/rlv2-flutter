import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.error, super.key});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Error',
      ),
      // Your error screen UI
      body: Center(
        child: Text('An error occurred: $error'),
      ),
    );
  }
}

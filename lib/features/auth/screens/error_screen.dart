import 'package:flutter/material.dart';
import 'package:rlv2_flutter/core/widgets/shared_scaffold.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.error, super.key});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return SharedScaffold(
      appBarTitle: 'Error',
      // Your error screen UI
      body: Center(
        child: Text('An error occurred: $error'),
      ),
    );
  }
}

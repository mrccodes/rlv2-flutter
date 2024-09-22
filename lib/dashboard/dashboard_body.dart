// lib/pages/dashboard_body.dart

import 'package:flutter/material.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual dashboard content
    return Center(
      child: Text(
        'Welcome to the Dashboard!',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

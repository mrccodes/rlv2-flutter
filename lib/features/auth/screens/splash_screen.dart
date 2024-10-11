import 'package:flutter/material.dart';
import 'package:rlv2_flutter/core/widgets/loading_widget.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'RecipeLab') ,
      body: Center(
        child: LoadingWidget(),
      ),
    );
  }
}

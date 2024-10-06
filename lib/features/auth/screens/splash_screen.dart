import 'package:flutter/material.dart';
import 'package:rlv2_flutter/core/widgets/loading_widget.dart';
import 'package:rlv2_flutter/core/widgets/shared_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedScaffold(
      appBarTitle: 'RecipeLab',
      showBottomNav: false,
      showDrawer: false,
      // Your splash screen UI
      body: Center(
        child: LoadingWidget(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_nav_drawer.dart';

class SharedScaffold extends ConsumerWidget {
  const SharedScaffold({
    required this.body,
    required this.appBarTitle,
    this.showBottomNav = true,
    this.showDrawer = true,
    super.key,
  });

  final Widget body;
  final String appBarTitle;
  final bool showBottomNav;
  final bool showDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen to authstate
    final authState = ref.watch(authNotifierProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();  // Unique scaffold key for this screen

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: appBarTitle, 
        showMenuButton: authState.isAuthenticated,
        scaffoldKey: scaffoldKey,  // Pass the key to CustomAppBar
      ),
      endDrawer: showDrawer && authState.isAuthenticated ? 
        const CustomDrawer() : 
        null, 
      bottomNavigationBar: showBottomNav && authState.isAuthenticated ? 
        const CustomBottomNavigationBar() : 
        null,
      body: body,
    );
  }
}

// shared_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/providers/drawer_state_provider.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_app_bar.dart';
import 'package:rlv2_flutter/features/navigation/widgets/custom_nav_drawer.dart';


class SharedScaffold extends ConsumerStatefulWidget {
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
  ConsumerState<SharedScaffold> createState() => _SharedScaffoldState();
}

class _SharedScaffoldState extends ConsumerState<SharedScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    // Listen to drawerStateProvider changes
    ref.listen<bool>(drawerStateProvider, (previous, next) {
      if (next) {
        // Open the drawer after the current frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_scaffoldKey.currentState!.isEndDrawerOpen) {
            _scaffoldKey.currentState!.openEndDrawer();
          }
        });
      } else {
        if (_scaffoldKey.currentState!.isEndDrawerOpen) {
          Navigator.of(context).pop(); // Closes the end drawer
        }
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: widget.appBarTitle,
        showMenuButton: authState.isAuthenticated,
      ),
      endDrawer: widget.showDrawer && authState.isAuthenticated
          ? const CustomDrawer()
          : null,
      bottomNavigationBar: widget.showBottomNav && authState.isAuthenticated
          ? const CustomBottomNavigationBar()
          : null,
      body: widget.body,
      onEndDrawerChanged: (isOpened) {
        // Synchronize the drawer state with the provider
        ref.read(drawerStateProvider.notifier).state = isOpened;
      },
    );
  }
}

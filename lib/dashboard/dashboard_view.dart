// lib/pages/dashboard_view.dart

import 'package:flutter/material.dart';
import 'package:rlv2_flutter/components/custom_app_bar.dart';
import 'package:rlv2_flutter/components/custom_nav_drawer.dart';
import 'package:rlv2_flutter/dashboard/dashboard_body.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        title: 'RecipeLab',
      ),
      endDrawer: const CustomDrawer(),
      body: const DashboardBody(),
    );
  }
}

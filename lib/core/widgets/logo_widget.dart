import 'package:flutter/material.dart';

/// A reusable widget that displays the app's logo.
///
/// [size] specifies the height of the logo. The width will adjust to maintain
/// the logo's aspect ratio.
class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    this.size = 120.0,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/icons/logo.png',
      fit: BoxFit.contain,
      height: size,
    );
  }
}

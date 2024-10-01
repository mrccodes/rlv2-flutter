import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/bootstrap.dart';

void main() {
  bootstrap(() => const ProviderScope(child: App()));
}

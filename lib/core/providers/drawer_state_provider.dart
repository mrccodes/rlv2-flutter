// providers/drawer_state_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A StateProvider that holds the state of the drawer (open/closed).
final drawerStateProvider = StateProvider<bool>((ref) => false);

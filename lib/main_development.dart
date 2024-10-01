import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/app/app.dart';
import 'package:rlv2_flutter/bootstrap.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await bootstrap(() => const ProviderScope(child: App()));
}

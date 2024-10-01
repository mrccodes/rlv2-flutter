import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> testSetup() async {
  // Mock environment variables for all tests
  // ignore: avoid_print
  print('Setting up tests...');

  dotenv.testLoad(fileInput: 'API_URL=https://api.example.com\n');

  // ignore: avoid_print
  print('Tests setup.');
}

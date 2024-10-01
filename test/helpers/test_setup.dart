import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> testSetup() async {
  // Mock environment variables for all tests
  dotenv.testLoad(fileInput: 'API_URL=https://api.example.com\n');
}

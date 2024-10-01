import 'package:mocktail/mocktail.dart';

import '../mocks/dot_env.dart';

Future<void> testSetup() async {
  // Mock environment variables for all tests
  // ignore: avoid_print
  print('Setting up tests...');
  final mockDotenv = MockDotEnv();
  when(mockDotenv.load).thenAnswer((_) async {
    // Simulate loading the .env file by providing static values
    when(() => mockDotenv.env).thenReturn({
      'API_URL': 'http://dummy-url-for-tests',
      'API_KEY': 'dummy-api-key',
    });
  });

  // ignore: avoid_print
  print('Tests setup.');
}

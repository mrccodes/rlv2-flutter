

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> testSetup() async {
      await dotenv
          .load(mergeWith: {'STRIPE_API': 'http://dummy-url-for-tests'});
    }
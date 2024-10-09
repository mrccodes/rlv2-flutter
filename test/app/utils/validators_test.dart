import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';
import 'package:rlv2_flutter/utils/validators.dart';

Widget makeTestableWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

// void main() {
//   group('StringValidators Tests', () {
//     late BuildContext context;
//     late StringValidators stringValidators;

//     setUp(() async {
//       // Build a minimal app to obtain a BuildContext with localization
//       final widget = makeTestableWidget(
//         Builder(
//           builder: (BuildContext buildContext) {
//             context = buildContext;
//             return Container();
//           },
//         ),
//       );

//       // Pump the widget to initialize the context
//       await createTestWidget(widget);

//       // Initialize StringValidators with the context
//       stringValidators = StringValidators(context);
//     });

    
//   });
// }

void main() {
  group('StringValidators Tests', () {
    late BuildContext context;
    late StringValidators stringValidators;

    setUp(() {
      // Initialization will happen in each test
    });

    Future<void> pumpTestWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext buildContext) {
              context = buildContext;
              return Container();
            },
          ),
        ),
      );
    }

    

    testWidgets('isValidName validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);

      final validator = stringValidators.isValidName;

      expect(validator.validate('John'), true);
      expect(validator.validate('John Doe'), true);
      expect(validator.validate('John-Doe'), true);
      expect(validator.validate("John' Doe"), true);
      expect(validator.validate('Nyankómàgó'), true);
      expect(validator.validate('John Doe 123'), false);
      expect(validator.validate('John Doe!'), false);
    });

    testWidgets('Password Length Short Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.passwordLengthShort;

      expect(validator.validate('12345678'), false);
      expect(validator.validate('123456789'), true);
    });

    testWidgets('Password Length Long Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.passwordLengthLong;

      expect(validator.validate('123456789012345678901'), false);
      expect(validator.validate('12345678901234567890'), true);
    });

    testWidgets('Password Number Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.passwordNumber;

      expect(validator.validate('password'), false);
      expect(validator.validate('password1'), true);
    });

    testWidgets('Password Symbol Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.passwordSymbol;

      expect(validator.validate('password'), false);
      expect(validator.validate('password!'), true);
    });

    testWidgets('Username Length Short Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.usernameLengthShort;

      expect(validator.validate('ab'), false);
      expect(validator.validate('abc'), true);
    });

    testWidgets('Username Length Long Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.usernameLengthLong;

      expect(validator.validate('abcdefghijks'), true);
      expect(validator.validate('abcdefghijkss'), false);
    });

    testWidgets('Username Symbol Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.usernameSymbol;

      expect(validator.validate('username'), true);
      expect(validator.validate('user_name'), true);
      expect(validator.validate('user_name123'), true);
      expect(validator.validate('user_name123'), true);
      expect(validator.validate('user_name!'), false);
    });

    testWidgets('Username No Space Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.usernameNoSpace;

      expect(validator.validate('username'), true);
      expect(validator.validate('user name'), false);
    });

    testWidgets('Email Is Valid Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.emailIsValid;

      expect(validator.validate('test@example.com'), true);
      expect(validator.validate('invalid-email'), false);
    });

    testWidgets('Email Not Empty Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.emailNotEmpty;

      expect(validator.validate(''), false);
      expect(validator.validate('asd'), true);
    });

    testWidgets('Password not empty validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.passwordNotEmpty;

      expect(validator.validate(''), false);
      expect(validator.validate('password'), true);
    });

    testWidgets('firstNameLengthLong Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.firstNameLengthLong;

      expect(validator.validate('asdasdasdasdasdasdas'), true);
      expect(validator.validate('asdasdasdasdasdasdasa'), false);
    });

    testWidgets('last name length long validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.lastNameLengthLong;

      expect(validator.validate('asdasdasdasdasdasdas'), true);
      expect(validator.validate('asdasdasdasdasdasdasa'), false);
    });

    testWidgets('firstNameSymbol Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.firstNameSymbol;

      expect(validator.validate('asd'), true);
      expect(validator.validate('asdasdasdasdasdasdasa'), false);
    });

    testWidgets('first name symbol validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.firstNameSymbol;

      expect(validator.validate('John'), true);
      expect(validator.validate('John Doe'), true);
      expect(validator.validate('John-Doe'), true);
      expect(validator.validate("John' Doe"), true);
      expect(validator.validate('Nyankómàgó'), true);
      expect(validator.validate('John Doe 123'), false);
      expect(validator.validate('John Doe!'), false);
    });

    testWidgets('last name symbol validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.lastNameSymbol;

      expect(validator.validate('John'), true);
      expect(validator.validate('John Doe'), true);
      expect(validator.validate('John-Doe'), true);
      expect(validator.validate("John' Doe"), true);
      expect(validator.validate('Nyankómàgó'), true);
      expect(validator.validate('John Doe 123'), false);
      expect(validator.validate('John Doe!'), false);
    });

    testWidgets('firstNameNumber Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.firstNameNumber;

      expect(validator.validate('asd'), true);
      expect(validator.validate('asd1'), false);
    });

    testWidgets('lastNameNumber Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.lastNameNumber;

      expect(validator.validate('asd'), true);
      expect(validator.validate('asd1'), false);
    });

    testWidgets('organizationNameLengthLong Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.organizationNameLengthLong;

      expect(validator.validate('asdasdasdasdasdasdasdasdasdasd'), true);
      expect(validator.validate('asdasdasdasdasdasdasdasdasdasasd'), false);
    });

    testWidgets('organziationNameNotEmpty Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.organziationNameNotEmpty;

      expect(validator.validate(''), false);
      expect(validator.validate('asdasd'), true);
    });

    testWidgets('organizationNameSymbol Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.organizationNameSymbol;

      expect(validator.validate('asdasd'), true);
      expect(validator.validate('asdasd!'), true);
      expect(validator.validate('Johnson & Johnson'), true);
      expect(validator.validate('Good Co., Ltd.'), true);
      expect(validator.validate('Best-Buy'), true);
      expect(validator.validate("O'Reilly Media, Inc."), true);
      expect(validator.validate('AT&T'), true);
      expect(validator.validate('AT&T'), true);
      expect(validator.validate('Invalid [Company]'), false);
      expect(validator.validate('Bad {Company}'), false);
      expect(validator.validate('Not<Allowed>'), false);
      expect(validator.validate('Wrong/Name'), false);
      expect(validator.validate(r'No\Backslashes'), false);
      expect(validator.validate('Equal=Sign'), false);
      expect(validator.validate('Plus+Sign'), false);
      expect(validator.validate('Under_score'), false);
      expect(validator.validate('Company Name with / Slash'), false);
      expect(validator.validate('Angle<Brackets>'), false);
    });

    testWidgets('organizationDescriptionLengthLong Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.organizationDescriptionLengthLong;

      const longDescriptionPass = 'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdd';

      const longDescriptionFail = 'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdd'
          'asdasdasddasdasdasdda';

      expect(validator.validate('asasd'), true);
      expect(validator.validate('asdasdasdasdasdasdasdasdasdasd'), true);
      expect(validator.validate(longDescriptionPass), true);
      expect(validator.validate(longDescriptionFail), false);
    });

    testWidgets('organizationDescriptionSymbol Validator', (WidgetTester tester) async {
      await pumpTestWidget(tester);
      stringValidators = StringValidators(context);
      final validator = stringValidators.organizationDescriptionSymbol;

      expect(validator.validate('asdasd'), true);
      expect(validator.validate('asdasd!'), true);
      expect(validator.validate('Johnson & Johnson'), true);
      expect(validator.validate('Good Co., Ltd.'), true);
      expect(validator.validate('Best-Buy'), true);
      expect(validator.validate("O'Reilly Media, Inc."), true);
      expect(validator.validate('AT&T'), true);
      expect(validator.validate('Invalid [Company]'), false);
      expect(validator.validate('Bad {Company}'), false);
      expect(validator.validate('Not<Allowed>'), false);
      expect(validator.validate('Wrong/Name'), false);
      expect(validator.validate(r'No\Backslashes'), false);
      expect(validator.validate('Equal=Sign'), false);
      expect(validator.validate('Plus+Sign'), false);
      expect(validator.validate('Under_score'), false);
      expect(validator.validate('Company Name with / Slash'), false);
      expect(validator.validate('Angle<Brackets>'), false);
    });
  });
}

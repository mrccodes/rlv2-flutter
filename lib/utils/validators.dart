// class ValidationMessages {
//   String passwordLengthShort = 'Password must be at least 9 characters';
//   String passwordLengthLong = 'Password must be less than 20 characters';
//   String passwordNumber = 'Password must contain at least one number';
//   String passwordSymbol = 'Password must contain at least one symbol';
//   String usernameLengthShort = 'Username must be at least 3 characters';
//   String usernameLengthLong = 'Username must be less than 12 characters';
//   String usernameSymbol =
//     'Username must contain only letters, numbers and underscores';
//   String invalidEmail = 'Email address is invalid';
//   String emptyEmail = 'Please enter your email';
//   String emptyPassword = 'Please enter your password';

// }

// validator.dart

import 'package:flutter/material.dart';
import 'package:rlv2_flutter/utils/email_regex.dart';
import 'package:rlv2_flutter/utils/regex.dart';
import 'package:rlv2_flutter/utils/symbol_regex.dart';

class Validator {
  Validator({required this.validate, required this.error});

  // Function that takes a string and returns a boolean
  // Returns true if the string is valid, false if it is not
  final bool Function(String) validate;
  final String error;
}
  
class StringValidators {
  final l10n = context.l10n;
  final isValidName = Validator(
    validate: (String val) => nameRegExp.hasMatch(val),
    error: l10n.invalidName,
  );
  final passwordLengthShort = Validator(
    validate: (String val) => val.length >= 9,
    error: 'Password must be at least 9 characters',
  );

  final passwordLengthLong = Validator(
    validate: (String val) => val.length <= 20,
    error: 'Password must be less than 20 characters',
  );

  final passwordNumber = Validator(
    validate: (String val) => numberRegex.hasMatch(val),
    error: 'Password must contain at least one number',
  );

  final passwordSymbol = Validator(
    validate: (String val) => symbolRegex.hasMatch(val),
    error: 'Password must contain at least one symbol',
  );

  final usernameLengthShort = Validator(
    validate: (String val) => val.length >= 3,
    error: 'Username must be at least 3 characters',
  );

  final usernameLengthLong = Validator(
    validate: (String val) => val.length <= 12,
    error: 'Username must be less than 12 characters',
  );

  final usernameSymbol = Validator(
    validate: (String val) => symbolRegexAllowUnderscore.hasMatch(val),
    error: 'Username must only contain letters, numbers, and underscores',
  );

  final usernameNoSpace = Validator(
    validate: (String val) => !val.contains(' '),
    error: 'Username must not contain spaces',
  );

  final emailIsValid = Validator(
    validate: (String val) => emailRegex.hasMatch(val),
    error: 'Email address is invalid',
  );

  final emailNotEmpty = Validator(
    validate: (String val) => val.isNotEmpty,
    error: 'Please enter your email',
  );

  final passwordNotEmpty = Validator(
    validate: (String val) => val.isNotEmpty,
    error: '',
  );

  final firstNameLengthLong = Validator(
    validate: (String val) => val.length <= 20,
    error: 'First name must be 20 or fewer characters',
  );

  final lastNameLengthLong = Validator(
    validate: (String val) => val.length <= 20,
    error: 'Last name must be 20 or fewer characters',
  );

  final firstNameSymbol = Validator(
    validate: (String val) => !nameRegExp.hasMatch(val),
    error: 'First name must only contain letters, '
    'spaces, hyphens, and apostrophes',
  );

  final lastNameSymbol = Validator(
    validate: (String val) => !symbolRegex.hasMatch(val),
    error: 'Last name must only contain letters, '
    'spaces, hyphens, and apostrophes',
  );

  final firstNameNumber = Validator(
    validate: (String val) => !numberRegex.hasMatch(val),
    error: 'First name must not contain numbers',
  );

  final lastNameNumber = Validator(
    validate: (String val) => !numberRegex.hasMatch(val),
    error: 'Last name must not contain numbers',
  );


  final organizationNameLengthLong = Validator(
    validate: (String val) => val.length <= 30,
    error: 'Organization name must be 30 or fewer characters',
  );

  final organziationNameNotEmpty = Validator(
    validate: (String val) => val.isNotEmpty,
    error: 'Please enter an organization name',
  );

  final organizationNameSymbol = Validator(
    validate: (String val) => !symbolRegex.hasMatch(val),
    error: 'Organization name must only contain letters and numbers and spaces',
  );

  final organizationDescriptionLengthLong = Validator(
    validate: (String val) => val.length <= 100,
    error: 'Organization description must be 100 or fewer characters',
  );

  final organizationDescriptionSymbol = Validator(
    validate: (String val) => !symbolRegex.hasMatch(val),
    error:
        'Organization description must only contain letters and numbers and spaces',
  );
}

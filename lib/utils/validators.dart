import 'package:flutter/material.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';
import 'package:rlv2_flutter/utils/regex.dart';

class Validator {
  Validator({required this.validate, required this.error});

  // Function that takes a string and returns a boolean
  // Returns true if the string is valid, false if it is not
  final bool Function(String) validate;
  final String error;
}
  
class StringValidators {
  StringValidators(this.context) {
    l10n = context.l10n;

    isValidName = Validator(
      validate: (String val) => nameRegExp.hasMatch(val),
      error: l10n.usernameSymbolError,
    );
    passwordLengthShort = Validator(
      validate: (String val) => val.length >= 9,
      error: l10n.passwordLengthShortError,
    );

    passwordLengthLong = Validator(
      validate: (String val) => val.length <= 20,
      error: l10n.passwordLengthLongError,
    );

    passwordNumber = Validator(
      validate: (String val) => numberRegex.hasMatch(val),
      error: l10n.passwordNumberError,
    );

    passwordSymbol = Validator(
      validate: (String val) => passwordSymbolRegex.hasMatch(val),
      error: l10n.passwordSymbolError,
    );

    usernameLengthShort = Validator(
      validate: (String val) => val.length >= 3,
      error: l10n.usernameLengthShortError,
    );

    usernameLengthLong = Validator(
      validate: (String val) => val.length <= 12,
      error: l10n.usernameLengthLongError,
    );

    usernameSymbol = Validator(
      validate: (String val) => !symbolRegexAllowUnderscore.hasMatch(val),
      error: l10n.usernameSymbolError,
    );

    usernameNoSpace = Validator(
      validate: (String val) => !val.contains(' '),
      error: l10n.usernameSpaceError,
    );

    emailIsValid = Validator(
      validate: (String val) => emailRegex.hasMatch(val),
      error: l10n.emailIsValidError,
    );

    emailNotEmpty = Validator(
      validate: (String val) => val.isNotEmpty,
      error: l10n.emailNotEmptyError,
    );

    passwordNotEmpty = Validator(
      validate: (String val) => val.isNotEmpty,
      error: l10n.passwordNotEmptyError,
    );

    firstNameLengthLong = Validator(
      validate: (String val) => val.length <= 20,
      error: l10n.firstNameLengthLongError,
    );

    lastNameLengthLong = Validator(
      validate: (String val) => val.length <= 20,
      error: l10n.lastNameLengthLongError,
    );

    firstNameSymbol = Validator(
      validate: (String val) => isValidName.validate(val),
      error: l10n.firstNameSymbolError,
    );

    lastNameSymbol = Validator(
      validate: (String val) => isValidName.validate(val),
      error: l10n.lastNameSymbolError,
    );

    firstNameNumber = Validator(
      validate: (String val) => !numberRegex.hasMatch(val),
      error: l10n.firstNameNumberError,
    );

    lastNameNumber = Validator(
      validate: (String val) => !numberRegex.hasMatch(val),
      error: l10n.lastNameNumberError,
    );

    organizationNameLengthLong = Validator(
      validate: (String val) => val.length <= 30,
      error: l10n.organizationNameLengthLongError,
    );

    organziationNameNotEmpty = Validator(
      validate: (String val) => val.isNotEmpty,
      error: l10n.organziationNameNotEmptyError,
    );

    organizationNameSymbol = Validator(
      validate: organizationNameRegex.hasMatch,
      error: l10n.organizationNameSymbolError,
    );

    organizationDescriptionLengthLong = Validator(
      validate: (String val) => val.length <= 100,
      error: l10n.organizationNameLengthLongError,
    );

    organizationDescriptionSymbol = Validator(
      validate: organizationNameRegex.hasMatch,
      error:
          l10n.organizationDescriptionSymbolError,
    );
  }

  final BuildContext context;
  late final AppLocalizations l10n;

  late final Validator isValidName;
  late final Validator passwordLengthShort;
  late final Validator passwordLengthLong;
  late final Validator passwordNumber;
  late final Validator passwordSymbol;
  late final Validator usernameLengthShort;
  late final Validator usernameLengthLong;
  late final Validator usernameSymbol;
  late final Validator usernameNoSpace;
  late final Validator emailIsValid;
  late final Validator emailNotEmpty;
  late final Validator passwordNotEmpty;
  late final Validator firstNameLengthLong;
  late final Validator lastNameLengthLong;
  late final Validator firstNameSymbol;
  late final Validator lastNameSymbol;
  late final Validator firstNameNumber;
  late final Validator lastNameNumber;
  late final Validator organizationNameLengthLong;
  late final Validator organziationNameNotEmpty;
  late final Validator organizationNameSymbol;
  late final Validator organizationDescriptionLengthLong;
  late final Validator organizationDescriptionSymbol;
}

String input = 'Your input string here';

RegExp numberRegex = RegExp(r'\d');

RegExp nameRegExp = RegExp(
  r"^[\p{L}\p{M}' \.\-]{1,20}$",
  unicode: true,
);

// Regular expression pattern for validating email addresses
RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}$',
  caseSensitive: false,
);

RegExp passwordSymbolRegex = RegExp(r'[!@#\$%\^&\*\?]');
RegExp passwordDisallowedSybmols = RegExp(r'[<>?{}[\]\/:;|`~_=+-]');

RegExp symbolRegex = RegExp(r'{[!@#\$%\^&\*\(\)]}-_+=\|:;,.?/<>');
RegExp symbolRegexAllowUnderscore =
    RegExp(r'[!@#\$%\^&\*\(\)\-\+=\|:;,.?/<>\[\]{}]');

final RegExp organizationNameRegex = RegExp(r"^[a-zA-Z0-9 &®™'.,\-!]+$");

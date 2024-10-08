String input = 'Your input string here';

RegExp numberRegex = RegExp(r'\d');


RegExp nameRegExp = 
  RegExp(
    r"^[\p{L}\p{M}' \.\-]{1,20}$", 
    unicode: true,
    );

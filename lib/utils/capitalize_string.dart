String capitalize(String s, {bool all = false}) => all
    ? s.split(' ').map(capitalize).join(' ')
    : s.isNotEmpty
        ? '${s[0].toUpperCase()}${s.substring(1)}'
        : s;

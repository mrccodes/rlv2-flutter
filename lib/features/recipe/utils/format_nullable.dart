String formatNullable(int? value) {
  return value?.toString() ?? '--';
}

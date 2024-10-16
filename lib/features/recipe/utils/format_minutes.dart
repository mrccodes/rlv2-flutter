String formatMinutes(int minutes) {
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;
  if (hours == 0) {
    return '$remainingMinutes min';
  }
  return '$hours hr $remainingMinutes min';
}

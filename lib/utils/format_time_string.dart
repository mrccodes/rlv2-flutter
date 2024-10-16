import 'package:timeago/timeago.dart' as timeago;

String formatTimeAgoString(String time) {
  final parsed = DateTime.parse(time);
  return timeago.format(parsed, allowFromNow: true);
}

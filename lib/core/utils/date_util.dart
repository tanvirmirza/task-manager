import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

String shortTimeAgo(String isoTime) {
  final time = DateTime.parse(isoTime).toUtc();
  final formatedTime = DateFormat("MMM dd, yyyy").format(time);
  final now = DateTime.now().toUtc();
  final diff = now.difference(time);

  if (diff.inSeconds < 60) {
    return '${diff.inSeconds} sec ago';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} min ago';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} hour ago';
  } else if(diff.inDays < 11){
    return '${diff.inDays} days ago';
  } else{
    return formatedTime;
  }
}

String timeAgo(String isoTime) {
  final time = DateTime.parse(isoTime).toUtc();
  final now = DateTime.now().toUtc();
  final diff = now.difference(time);

  if (diff.inSeconds < 10) {
    return 'now';
  }
  else {
    // More than 60 seconds — show time like 10:00 AM/PM
    return DateFormat('hh:mm a').format(time.toLocal());
  }
}


String formatDayTime(String isoTime) {
  final time = DateTime.parse(isoTime).toLocal();
  final now = DateTime.now();

  final isToday = now.year == time.year &&
      now.month == time.month &&
      now.day == time.day;

  final yesterday = now.subtract(const Duration(days: 1));
  final isYesterday = yesterday.year == time.year &&
      yesterday.month == time.month &&
      yesterday.day == time.day;

  if (isToday) {
    return 'Today';
  } else if (isYesterday) {
    return 'Yesterday';
  } else {
    return DateFormat('dd MMM yyyy').format(time);
  }
}

String dateTimeFormat(String isoTime){
  final time = DateTime.parse(isoTime).toLocal();
  return DateFormat('dd MMM yyyy').format(time);
}
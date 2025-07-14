import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class FunctionLogic {
  // Greeting based on time of day
   String showGreetings() {
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  // Format time ago using DateTime input
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
    } else {
      return DateFormat("dd/MM/yy").format(dateTime);
    }
  }

  // Format ISO time into short time ago format
  static String shortTimeAgo(String isoTime) {
    final time = DateTime.parse(isoTime).toUtc();
    final formattedTime = DateFormat("MMM dd, yyyy").format(time);
    final now = DateTime.now().toUtc();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} sec ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour ago';
    } else if (diff.inDays < 11) {
      return '${diff.inDays} days ago';
    } else {
      return formattedTime;
    }
  }

  // Format ISO time into "now" or "hh:mm a"
  static String timeAgo(String isoTime) {
    final time = DateTime.parse(isoTime).toUtc();
    final now = DateTime.now().toUtc();
    final diff = now.difference(time);

    if (diff.inSeconds < 10) {
      return 'now';
    } else {
      return DateFormat('hh:mm a').format(time.toLocal());
    }
  }

  // Format ISO time to Today, Yesterday or formatted date
  static String formatDayTime(String isoTime) {
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

  // Format ISO time to dd MMM yyyy
  static String dateTimeFormat(String isoTime) {
    final time = DateTime.parse(isoTime).toLocal();
    return DateFormat('EEEE, MMMM d').format(time);
  }

}

import 'package:flutter/material.dart';

enum TaskStatus { sNew, progress, completed, cancelled, upcoming }

class FuntionLogic {

  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else {
      return "${dateTime.day}/${dateTime.month}/${dateTime.year % 100}";
    }
  }

  static String showGrettings() {
    int now = DateTime.now().hour;
    if (now >= 5 && now < 12) {
      return "Good Morning";
    } else if (now >= 12 && now < 17) {
      return "Good Afternoon";
    } else if (now >= 17 && now < 21) {
      return "Good Evening";
    } else {
      return "Good Nignt";
    }
    // else if (now >= 21 && now < 5) {
    //   return "Good Nignt";
    // }
    // else {
    //   return "What's up";
    // }
  }

  Color getStatusChipColor(TaskStatus taskStatus) {
    late Color color;
    switch (taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
      case TaskStatus.progress:
        color = Colors.purple;
      case TaskStatus.completed:
        color = Colors.green;
      case TaskStatus.cancelled:
        color = Colors.red;
      case TaskStatus.upcoming:
        color = Colors.grey;
    }
    return color;
  }
}

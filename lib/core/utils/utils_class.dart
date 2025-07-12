import 'dart:io';
import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/image_path.dart';
import 'package:task_manager/core/theme/app_colors.dart';

Widget buildProfileAvatar({
  String? imageUrl,
  File? imageFile,
  double? imageSize,
  double borderWidth = 2,
  Color borderColor = Colors.white,
}) {
  final double size = imageSize ?? 40.0;

  bool isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  Widget buildImage(Widget imageWidget) {
    return Container(
      width: size * 2,
      height: size * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: ClipOval(child: imageWidget),
    );
  }

  if (imageFile != null) {
    return buildImage(
      Image.file(
        imageFile,
        width: size * 2,
        height: size * 2,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImagePath.blankProfile,
            width: size * 2,
            height: size * 2,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  } else if (imageUrl != null && imageUrl.isNotEmpty && isNetworkUrl(imageUrl)) {
    return buildImage(
      Image.network(
        imageUrl,
        width: size * 2,
        height: size * 2,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImagePath.blankProfile,
            width: size * 2,
            height: size * 2,
            fit: BoxFit.cover,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: AppColors.white,
            ),
          );
        },
      ),
    );
  } else {
    return buildImage(
      Image.asset(
        ImagePath.blankProfile,
        width: size * 2,
        height: size * 2,
        fit: BoxFit.cover,
      ),
    );
  }
}




String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}


Widget buildRefreshIndicator({
  required Widget child,
  required RefreshCallback onRefresh,
}) {
  return RefreshIndicator(

    onRefresh: onRefresh,
    color: AppColors.black,
    backgroundColor: const Color(0xFFE2E8F0),
    child: child,
  );
}

enum TaskStatus { sNew, progress, completed, cancelled, upcoming }
  // Get color based on task status
   Color getStatusChipColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.sNew:
        return Colors.blue;
      case TaskStatus.progress:
        return Colors.purple;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.cancelled:
        return Colors.red;
      case TaskStatus.upcoming:
        return Colors.grey;
    }
  }
































/*

//hasImage ||
Widget buildProfileAvatar({
  String? imageUrl,
  String? username,
  double? imageSize,
}) {
  final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;
  return CircleAvatar(
    radius: imageSize ?? 40.r,
    backgroundColor: hasImage ? Colors.transparent : getRandomColor(),
    backgroundImage: hasImage ? NetworkImage(imageUrl) : null,
    child:
        hasImage
            ? null
            : Text(
              (username?.isNotEmpty ?? false)
                  ? username!.substring(0, 1).toUpperCase()
                  : '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
  );
}

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
*/

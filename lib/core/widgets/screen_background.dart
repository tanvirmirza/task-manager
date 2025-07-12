import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/core/constants/image_path.dart';


class ScreenBackground extends StatelessWidget {
  
  const ScreenBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            ImagePath.backgroundSvg,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          child
        ],
      ),
    );
  }
}

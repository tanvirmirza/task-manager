import 'package:flutter/material.dart';

import '../screens/bottom_nav_screens/profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.fromProfileScreen,
    this.elevation,
    this.bottom,
  });

  final bool? fromProfileScreen;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TMAppBar> createState() => _TMAppBarState();
}

class _TMAppBarState extends State<TMAppBar> {
  bool _isLightMode = true;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: widget.elevation,
      forceMaterialTransparency: true,
      bottom: widget.bottom,
      backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          if (widget.fromProfileScreen ?? false) {
            return;
          }
          _onTapProfileSection(context);
        },
        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Rahim Hasan',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    _showGrettings(),
                    style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _isLightMode = !_isLightMode;
            setState(() {});
          },
          highlightColor: Colors.white,
          hoverColor: Colors.white,
          icon: Icon(_isLightMode ? Icons.light_rounded : Icons.dark_mode),
        )
      ],
    );
  }

  void _onTapProfileSection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  String _showGrettings() {
    int now = DateTime.now().hour;
    if (now >= 5 && now < 12) {
      return "Good Morning";
    } else if (now >= 12 && now < 17) {
      return "Good Afternoon";
    } else if (now >= 17 && now < 21) {
      return "Good Evening";
    } else if (now >= 21 && now < 5) {
      return "Good Nignt";
    } else {
      return "What's up";
    }
  }
}

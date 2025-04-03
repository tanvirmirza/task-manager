import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/image_provider.dart';

import '../views/home/profile_edit_screen.dart';

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
                  Consumer<ImagePickProvider>(
                    builder: (context, provider, child) {
                      XFile? image = provider.profileImage;
                      if (image == null) {
                        return const CircleAvatar(
                          radius: 16,
                          child: Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.grey,
                          ),
                        );
                      }

                      return ClipOval(
                        child: kIsWeb
                            ? Image.network(
                                image.path,
                                fit: BoxFit.cover,
                                width: 32,
                                height: 32,
                              )
                            : Image.file(
                                File(image.path),
                                fit: BoxFit.cover,
                                width: 32,
                                height: 32,
                              ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Mirza Tanvir',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _showGrettings(),
                          style:
                              textTheme.bodyLarge?.copyWith(color: Colors.grey),
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
        builder: (context) => const ProfileEditScreen(),
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
}

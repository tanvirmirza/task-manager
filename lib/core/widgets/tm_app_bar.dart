import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/core.dart';
import 'package:task_manager/provider/image_provider.dart';

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
        child: Row(children: [
          Consumer<ImagePickProvider>(
            builder: (context, provider, child) {
              XFile? image = provider.profileImage;
              if (image == null) {
                return CircleAvatar(
                  radius: 16,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
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
                  'Hi, Mirza Tanvir 👋',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                Text(
                  FuntionLogic.showGrettings(),
                  style: textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      actions: [
        widget.fromProfileScreen == true
            ? IconButton(
                onPressed: () {
                  _isLightMode = !_isLightMode;
                  setState(() {});
                },
                highlightColor: Colors.white,
                hoverColor: Colors.white,
                icon:
                    Icon(_isLightMode ? Icons.light_rounded : Icons.dark_mode),
              )
            : Badge(
                label: const Text('2'),
                alignment: AlignmentDirectional.centerEnd,
                offset: const Offset(-4, -7),
                textColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  onPressed: () {},
                  highlightColor: Colors.white,
                  hoverColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
              )
      ],
    );
  }

  void _onTapProfileSection(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/profileEditScreen',
    );
  }
}

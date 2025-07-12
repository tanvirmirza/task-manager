import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/core/utils/time_util.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.fromProfileScreen = false,
    this.elevation,
    this.bottom,
  });

  final bool fromProfileScreen;
  final double? elevation;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppBarController());

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: elevation,
      bottom: bottom,
      backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          if (!fromProfileScreen) {
            Navigator.pushNamed(context, '/profileEditScreen');
          }
        },
        child: Row(children: [
          Obx(() {
            final image = controller.profileImage.value;
            if (image == null) {
              return CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            return ClipOval(
              child: kIsWeb
                  ? Image.network(image.path, fit: BoxFit.cover, width: 32, height: 32)
                  : Image.file(File(image.path), fit: BoxFit.cover, width: 32, height: 32),
            );
          }),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Mirza Tanvir 👋',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                Text(
                  FunctionLogic.showGreetings(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      actions: [
        fromProfileScreen
            ? Obx(() => IconButton(
          onPressed: controller.toggleTheme,
          icon: Icon(
            controller.isLightMode.value ? Icons.light_rounded : Icons.dark_mode,
          ),
        ))
            : Badge(
          label: const Text('2'),
          alignment: AlignmentDirectional.centerEnd,
          offset: const Offset(-4, -7),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        )
      ],
    );
  }
}



class AppBarController extends GetxController {
  final Rx<XFile?> profileImage = Rx<XFile?>(null);
  final RxBool isLightMode = true.obs;

  void toggleTheme() {
    isLightMode.value = !isLightMode.value;
  }

  void updateImage(XFile image) {
    profileImage.value = image;
  }
}
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/widgets/tm_app_bar.dart';
import 'package:task_manager/features/profile/view/controller/profile_view_controller.dart';

class ProfileViewScreen extends StatelessWidget {
  ProfileViewScreen({super.key});

  final controller = Get.put(ProfileViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(fromProfileScreen: true),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileImage(context),
                  const SizedBox(height: 20),
                  const Center(
                    child: Column(
                      children: [
                        Text("Mirza Tanvir",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        Text("mirzatanvir74@gmail.com",
                            style:
                            TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      taskStatus('PROGRESS', '3', context),
                      taskStatus('COMPLETED', '9', context),
                      taskStatus('CANCELLED', '4', context),
                    ],
                  ),
                  const SizedBox(height: 15),
                  sectionTitle('Appearance'),
                  profileTile(
                    title: 'Theme',
                    subtitle: 'Change the theme of the app',
                    icon: Icons.color_lens,
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  sectionTitle('Account'),
                  profileTile(
                    title: 'Privacy',
                    subtitle: 'Manage your privacy settings',
                    icon: Icons.lock_outline,
                    context: context,
                  ),
                  profileTile(
                    title: 'Help & Support',
                    subtitle: 'Get help or contact support',
                    icon: Icons.help_outline,
                    context: context,
                  ),
                  profileTile(
                    title: 'About',
                    subtitle: 'App information and version',
                    icon: Icons.info_outline,
                    context: context,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.logout,
                          label: const Text('LOGOUT',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.goToEdit,
                          label: const Text('EDIT',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  )
                ],
              )),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Obx(() {
            final image = controller.profileImage.value;
            return CircleAvatar(
              radius: 90,
              backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              child: ClipOval(
                child: image == null
                    ? Icon(Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary)
                    : kIsWeb
                    ? Image.network(image.path,
                    width: 180, height: 180, fit: BoxFit.cover)
                    : Image.file(File(image.path),
                    width: 180, height: 180, fit: BoxFit.cover),
              ),
            );
          }),
          Positioned(
            bottom: 10,
            right: 10,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: controller.pickImage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );

  Widget profileTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required BuildContext context,
  }) {
    return Card(
      elevation: 0.5,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.2),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }

  Widget taskStatus(String label, String value, BuildContext context) {
    return Card(
      elevation: 0.5,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                )),
            Text(label,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

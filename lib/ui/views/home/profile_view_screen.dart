import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/image_provider.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        fromProfileScreen: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Consumer<ImagePickProvider>(
          builder: (context, provider, child) {
            XFile? image = provider.profileImage;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: image == null
                        ? Stack(children: [
                            const CircleAvatar(
                              radius: 80,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                            Positioned(
                              bottom: 7,
                              right: 1,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: IconButton(
                                  icon: const Icon(CupertinoIcons.pencil),
                                  onPressed: () {},
                                  hoverColor: Colors.grey[100],
                                ),
                              ),
                            ),
                          ])
                        : ClipOval(
                            child: kIsWeb
                                ? Image.network(
                                    image.path,
                                    fit: BoxFit.cover,
                                    width: 160,
                                    height: 160,
                                  )
                                : Image.file(
                                    File(image.path),
                                    fit: BoxFit.cover,
                                    width: 160,
                                    height: 160,
                                  ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                          text: '      Mirza Tanvir\n',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'mirzatanvir74@gmail.com',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      taskStatus(label: 'PROGRESS', value: '3'),
                      taskStatus(label: 'COMPLETED', value: '9'),
                      taskStatus(label: 'CENCELLED', value: '4'),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text('Appearance',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  profileTile(
                      title: 'Theme',
                      subtitle: 'Change the theme of the app',
                      leading: const Icon(Icons.color_lens)),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Account',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  profileTile(
                      title: 'Privacy',
                      subtitle: 'Manage your privacy settings',
                      leading: const Icon(Icons.lock_outline)),
                  const SizedBox(
                    height: 8,
                  ),
                  profileTile(
                      title: 'Help & Support',
                      subtitle: 'Get help or contact support',
                      leading: const Icon(Icons.help_outline)),
                  const SizedBox(
                    height: 8,
                  ),
                  profileTile(
                      title: 'About',
                      subtitle: 'App information and version',
                      leading: const Icon(Icons.info_outline)),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'LOGOUT',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _onProfileEdit(context),
                          label: const Text(
                            'EDIT',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          icon: const Icon(CupertinoIcons.pencil),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ListTile profileTile(
      {required String title,
      required String subtitle,
      required Icon leading}) {
    return ListTile(
      leading: leading,
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          )),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.navigate_next),
    );
  }

  Widget taskStatus({required String label, required String value}) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                blurRadius: 4, color: Colors.black12, offset: Offset(1, 2)),
          ],
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        height: 50,
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: label.length * 10.0 + 20,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
            ),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }

  void _onProfileEdit(BuildContext context) {
    Navigator.pushNamed(context,'/profileEditScreen',
        );
  }
}

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/image_provider.dart';
import '../../widgets/profile_text_field.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool _isNewObscure = true;
  bool _isConfirmObscre = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Update Profile',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 4,
                        color: Colors.black12,
                        offset: Offset(0, 3)),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Consumer<ImagePickProvider>(
                            builder: (context, provider, child) {
                              XFile? image = provider.profileImage;

                              if (image == null) {
                                return const CircleAvatar(
                                  radius: 80,
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              }

                              return ClipOval(
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
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: _onUploadImage,
                          label: const Text(
                            'UPLOAD YOUR IMAGE',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          icon: const Icon(Icons.photo_library),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const ProfileTextField(
                          hintText: 'First Name',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ProfileTextField(
                          hintText: 'Last Name',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ProfileTextField(
                          hintText: 'Phone',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ProfileTextField(
                          hintText: 'Email',
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.delete,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'DELETE ACCOUNT',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 4,
                        color: Colors.black12,
                        offset: Offset(1, 2)),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 40,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.black12,
                                    offset: Offset(0, 2)),
                              ],
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: const Text(
                            'Change Your Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ProfileTextField(
                        hintText: 'New Password',
                        obscureText: _isNewObscure,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isNewObscure = !_isNewObscure;
                              });
                            },
                            icon: Icon(_isNewObscure
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        hintText: 'Confirm Password',
                        obscureText: _isConfirmObscre,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmObscre = !_isConfirmObscre;
                              });
                            },
                            icon: Icon(_isConfirmObscre
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'CHANGE PASSWORD',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'LOGOUT',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          icon: const Icon(Icons.exit_to_app),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _onUploadImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      ImagePickProvider().updateProfileImage(image);
      context.read<ImagePickProvider>().updateProfileImage(image);
    }
  }
}

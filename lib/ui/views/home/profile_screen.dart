import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/profile_text_field.dart';
import '../../widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isNewObscure = true;
  bool _isConfirmObscre = true;
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        fromProfileScreen: true,
      ),
      // backgroundColor: const Color(0xFFF6F5F5),
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
                        Center(
                          child: Container(
                            height: 40,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 3,
                                      color: Colors.black12,
                                      offset: Offset(1, 2)),
                                ],
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: const Text(
                              'Personal Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: CircleAvatar(radius: 80, child: imageView()),
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
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Widget imageView() {
    return _image == null
        ? const Icon(
            Icons.photo,
            size: 50,
          )
        : kIsWeb
            ? ClipOval(
                child: Image.network(
                  _image!.path,
                  fit: BoxFit.cover,
                  height: 160,
                  width: 160,
                ),
              )
            : ClipOval(
                child: Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover,
                  height: 160,
                  width: 160,
                ),
              );
  }
}

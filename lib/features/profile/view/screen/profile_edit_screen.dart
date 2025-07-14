import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/widgets/app_button.dart';
import 'package:task_manager/core/widgets/app_text_field.dart';
import 'package:task_manager/features/profile/view/controller/edit_profile_controller.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final controller = Get.find<ProfileEditController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
        title: const Text('Update Profile', style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildProfileCard(context),
            const SizedBox(height: 20),
            _buildPasswordCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Obx(() {
              final image = controller.profileImage.value;
              if (image == null) {
                return CircleAvatar(
                  radius: 80,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  child: Icon(Icons.person,
                      size: 50, color: Theme.of(context).colorScheme.primary),
                );
              }

              return ClipOval(
                child: kIsWeb
                    ? Image.network(image.path,
                        width: 160, height: 160, fit: BoxFit.cover)
                    : Image.file(File(image.path),
                        width: 160, height: 160, fit: BoxFit.cover),
              );
            }),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: controller.pickImage,
            icon: const Icon(Icons.photo_library),
            label: const Text('UPLOAD YOUR IMAGE'),
          ),
          const SizedBox(height: 30),
          AppTextField(hintText: 'First Name',controller: controller.firstNameController,),
          const SizedBox(height: 20),
           AppTextField(hintText: 'Last Name',controller: controller.lastNameController),
          const SizedBox(height: 20),
           AppTextField(
              hintText: 'Phone', keyboardType: TextInputType.phone,controller: controller.mobileController),
          const SizedBox(height: 20),
           AppTextField(
              hintText: 'Email', keyboardType: TextInputType.emailAddress, controller: controller.emailController,),
          const SizedBox(height: 25),
          AppButton(
            text: 'UPDATE',
            onTap: controller.updateProfile,
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_forever, color: Colors.red),
              SizedBox(width: 5),
              Text(
                'DELETE ACCOUNT',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPasswordCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(blurRadius: 4, color: Colors.black12),
                ],
              ),
              child: const Text(
                'Change Your Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Obx(() => AppTextField(
                hintText: 'New Password',
                controller: controller.newPasswordController,

                obscureText: controller.isNewObscure.value,
                textInputAction: TextInputAction.next,
                suffixIcon: IconButton(
                  icon: Icon(controller.isNewObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: controller.toggleNewObscure,
                ),
              )),
          const SizedBox(height: 20),
          Obx(() => AppTextField(
                hintText: 'Confirm Password',
                controller: controller.confirmPasswordController,
                obscureText: controller.isConfirmObscure.value,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  icon: Icon(controller.isConfirmObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: controller.toggleConfirmObscure,
                ),
              )),
          const SizedBox(height: 16),
          AppButton(
            text: "CHANGE PASSWORD",
            onTap: controller.changePassword,
          ),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton.icon(
              onPressed: controller.logout,
              icon: const Icon(Icons.logout),
              label: const Text('LOGOUT'),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(blurRadius: 4, color: Colors.black12, offset: Offset(0, 2)),
      ],
    );
  }
}

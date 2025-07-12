import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewController extends GetxController {
  Rx<XFile?> profileImage = Rx<XFile?>(null);

  void pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = picked;
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }

  void goToEdit() {
    Get.toNamed('/profileEditScreen');
  }
}

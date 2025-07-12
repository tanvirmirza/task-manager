import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditController extends GetxController {
  RxBool isNewObscure = true.obs;
  RxBool isConfirmObscure = true.obs;

  Rx<XFile?> profileImage = Rx<XFile?>(null);

  void toggleNewObscure() => isNewObscure.toggle();
  void toggleConfirmObscure() => isConfirmObscure.toggle();

  void pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = picked;
    }
  }

  void updateProfile() {
    // Simulated update logic
    Get.snackbar('Profile Updated', 'Your profile has been updated',
        snackPosition: SnackPosition.BOTTOM);
  }

  void changePassword() {
    // Simulated change password logic
    Get.snackbar('Password Changed', 'Your password has been updated',
        snackPosition: SnackPosition.BOTTOM);
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}

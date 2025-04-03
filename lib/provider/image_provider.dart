import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickProvider extends ChangeNotifier {
  XFile? _profileImage;
  XFile? get profileImage => _profileImage;

  void updateProfileImage(XFile? image) {
    _profileImage = image;
    notifyListeners();
  }
}

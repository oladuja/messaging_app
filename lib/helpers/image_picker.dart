import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();
// Pick an image.
Future<XFile?> pickImage() {
  return picker.pickImage(
      source: ImageSource.gallery, maxHeight: 225, maxWidth: 225, imageQuality: 50);
}

// Capture a photo.
Future<XFile?> captureImage() async {
  return picker.pickImage(source: ImageSource.camera);
}

import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();
// Pick an image.

void pickImage() async {
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
}
// Capture a photo.

void captureImage() async {
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
}

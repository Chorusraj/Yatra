import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFromCamera() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.camera);
    return picked != null ? File(picked.path) : null;
  }

  Future<File?> pickFromGallery() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}

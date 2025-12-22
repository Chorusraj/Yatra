import 'dart:io';
import 'package:dio/dio.dart';

class CloudinaryService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static const String cloudName = "drs6tcuzz";
  static const String uploadPreset = "flutter_unsigned";

  Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path),
        "upload_preset": uploadPreset,
        "folder": "flutter_uploads",
      });

      final response = await _dio.post(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
        data: formData,
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['error']?['message'] ?? "Image upload failed",
      );
    }
  }
}

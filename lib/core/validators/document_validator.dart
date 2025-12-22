import 'dart:io';

import 'package:yatra/core/constants/app_string.dart';

class DocumentValidationResult {
  final String? documentError;
  final String? photoError;

  const DocumentValidationResult({this.documentError, this.photoError});

  bool get isValid => documentError == null && photoError == null;
}

class DocumentValidator {
  static DocumentValidationResult validate({
    required String? selectedDoc,
    required File? profileImage,
    required File? frontImage,
    required File? backImage,
    required File? singleDocImage,
  }) {
    String? docError;
    String? photoError;

    if (profileImage == null) {
      photoError = photoErrorLabel;
    }

    if (selectedDoc == null) {
      docError = docErrorTypeLabel;
    } else if (selectedDoc == "Citizenship") {
      if (frontImage == null || backImage == null) {
        docError = docErrorLabel1;
      }
    } else {
      if (singleDocImage == null) {
        docError = docErrorLabel2;
      }
    }

    return DocumentValidationResult(
      documentError: docError,
      photoError: photoError,
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';

class UploadBox extends StatelessWidget {
  final String label;
  final File? imageFile;
  final VoidCallback? onTap;

  const UploadBox({super.key, required this.label, this.imageFile, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 135,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined),
                  SizedBox(height: 8),
                  Text(label),
                ],
              ),
      ),
    );
  }
}

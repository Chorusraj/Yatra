import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'upload_box.dart';

class RemovableUploadBox extends StatelessWidget {
  final String label;
  final File? imageFile;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const RemovableUploadBox({
    super.key,
    required this.label,
    this.imageFile,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style:  TextStyle(fontWeight: FontWeight.w500),),
        SizedBox(height: 6),
        Stack(
          children: [
            UploadBox(
              label: browseFileLabel,
              imageFile: imageFile,
              onTap: onTap,
            ),
            if (imageFile != null)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onRemove,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

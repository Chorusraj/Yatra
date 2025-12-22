import 'dart:io';
import 'package:flutter/material.dart';

class ProfilePhotoPicker extends StatelessWidget {
  final File? imageFile;
  final VoidCallback? onPick;
  final VoidCallback? onRemove;

  const ProfilePhotoPicker({
    super.key,
    this.imageFile,
    this.onPick,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onPick,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              image: imageFile != null
                  ? DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imageFile == null
                ? Icon(Icons.person, size: 50, color: Colors.grey)
                : null,
          ),
        ),
        if (imageFile != null)
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: onRemove,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.red,
                child: Icon(Icons.close, size: 18, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

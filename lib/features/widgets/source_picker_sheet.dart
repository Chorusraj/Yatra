import 'package:flutter/material.dart';
import 'package:yatra/core/constants/app_string.dart';

class SourcePickerSheet {
  static void show({
    required BuildContext context,
    VoidCallback? onCamera,
    VoidCallback? onGallery,
    VoidCallback? onFile,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text(cameraLabel),
                onTap: onCamera,
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(galleryLabel),
                onTap: onGallery,
              ),
              if (onFile != null)
                ListTile(
                  leading: Icon(Icons.attach_file),
                  title: Text(pickFileLabel),
                  onTap: onFile,
                ),
            ],
          ),
        );
      },
    );
  }
}

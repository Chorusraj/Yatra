import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yatra/core/constants/app_color.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'package:yatra/features/widgets/custom_button.dart';
import 'removable_upload_box.dart';

class DocumentUploadBottomSheet extends StatelessWidget {
  final String? documentType;
  final File? frontImage;
  final File? backImage;
  final File? singleImage;

  final VoidCallback onPickFront;
  final VoidCallback onPickBack;
  final VoidCallback onPickSingle;

  final VoidCallback onRemoveFront;
  final VoidCallback onRemoveBack;
  final VoidCallback onRemoveSingle;

  final VoidCallback onUpload;

   DocumentUploadBottomSheet({
    super.key,
    required this.documentType,
    this.frontImage,
    this.backImage,
    this.singleImage,
    required this.onPickFront,
    required this.onPickBack,
    required this.onPickSingle,
    required this.onRemoveFront,
    required this.onRemoveBack,
    required this.onRemoveSingle,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCitizenship = documentType == "Citizenship";

    final bool canUpload = isCitizenship
        ? frontImage != null && backImage != null
        : singleImage != null;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
           SizedBox(height: 20),

          if (isCitizenship) ...[
            RemovableUploadBox(
              label: citizenshipFrontlabel,
              imageFile: frontImage,
              onTap: onPickFront,
              onRemove: onRemoveFront,
            ),
            SizedBox(height: 15),
            RemovableUploadBox(
              label: citizenshipBacklabel,
              imageFile: backImage,
              onTap: onPickBack,
              onRemove: onRemoveBack,
            ),
          ] else
            RemovableUploadBox(
              label: "$documentType Image",
              imageFile: singleImage,
              onTap: onPickSingle,
              onRemove: onRemoveSingle,
            ),

         SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: CustomButton(
              backgroundColor: primaryColor,
              onPressed: canUpload
                  ? () {
                      Navigator.pop(context);
                      onUpload();
                    }
                  : null,
              child:  Text(
                uploadLabel,
                style: TextStyle(color: Colors.white),
              ),
            )
          ),
        ],
      ),
    );
  }
}

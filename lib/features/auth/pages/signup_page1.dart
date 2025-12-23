import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/core/constants/app_color.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'package:yatra/core/services/cloudinary_service.dart';
import 'package:yatra/core/services/image_picker_service.dart';
import 'package:yatra/core/utils/helper.dart';
import 'package:yatra/core/utils/route_generator.dart';
import 'package:yatra/core/utils/routes.dart';
import 'package:yatra/core/validators/document_validator.dart';
import 'package:yatra/features/auth/bloc/auth_bloc.dart';
import 'package:yatra/features/auth/bloc/auth_state.dart';
import 'package:yatra/features/auth/model/user.dart';
import 'package:yatra/features/widgets/custom_button.dart';
import 'package:yatra/features/widgets/custom_dropdown.dart';
import 'package:yatra/features/widgets/document_upload_sheet.dart';
import 'package:yatra/features/widgets/profile_photo_picker.dart';
import 'package:yatra/features/widgets/form_error_text.dart';
import 'package:yatra/features/widgets/source_picker_sheet.dart';
import 'package:yatra/features/widgets/upload_box.dart';

class SignupPage1 extends StatefulWidget {
  final AppUser user;

  const SignupPage1({super.key, required this.user});

  @override
  State<SignupPage1> createState() => _SignupPage1State();
}

class _SignupPage1State extends State<SignupPage1> {
  final List<String> documentType = ["Citizenship", "National Id", "Passport"];

  final ImagePickerService _imageService = ImagePickerService();
  final CloudinaryService _cloudinary = CloudinaryService();

  String? selectedDoc;

  File? profileImage;
  File? frontImage;
  File? backImage;
  File? singleDocImage;

  String? docError;
  String? photoError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      RouteGenerator.navigateToPage(
                        context,
                        Routes.signupPageRoute,
                      );
                    },
                    child: Icon(Icons.arrow_back_ios),
                  ),

                  SizedBox(height: 15),
                  Text(
                    createAccountLabel,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    signupSubtitleLabel,
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),

                  SizedBox(height: 40),

                  /// PROFILE PHOTO
                  Text(
                    profilePhotoUploadLabel,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 3),
                  ProfilePhotoPicker(
                    imageFile: profileImage,
                    onPick: () => _showSourcePicker(isProfile: true),
                    onRemove: () => setState(() => profileImage = null),
                  ),
                  FormErrorText(error: photoError),

                  SizedBox(height: 22),

                  /// DOCUMENT TYPE
                  Text(
                    documentTypeLabel,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 3),
                  CustomDropdown(
                    hintText: dropDownHintLabel,
                    items: documentType,
                    onChanged: (value) {
                      setState(() {
                        selectedDoc = value;
                        frontImage = null;
                        backImage = null;
                        singleDocImage = null;
                        docError = null;
                      });
                    },
                  ),

                  SizedBox(height: 22),

                  /// DOCUMENT UPLOAD
                  UploadBox(
                    label: documentUploadLabel,
                    imageFile: selectedDoc == "Citizenship"
                        ? null
                        : singleDocImage,
                    onTap: selectedDoc == null
                        ? null
                        : _showDocumentBottomSheet,
                  ),
                  FormErrorText(error: docError),

                  SizedBox(height: 65),

                  /// SUBMIT
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      backgroundColor: primaryColor,
                      borderRadius: 8,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      onPressed: _validateAndSubmit,
                      child: Text(
                        signupLabel,
                        style: TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (context.watch<AuthBloc>().state is AuthLoadingState)
              backdropFilter(context),
          ],
        ),
      ),
    );
  }

  // ---------------- SOURCE PICKER ----------------

  void _showSourcePicker({bool isFront = true, bool isProfile = false}) {
    SourcePickerSheet.show(
      context: context,
      onCamera: () async {
        Navigator.pop(context);
        final file = await _imageService.pickFromCamera();
        _handlePickedFile(file, isFront, isProfile);
      },
      onGallery: () async {
        Navigator.pop(context);
        final file = await _imageService.pickFromGallery();
        _handlePickedFile(file, isFront, isProfile);
      },
      onFile: () async {
        Navigator.pop(context);
        final file = await _imageService.pickFile();
        _handlePickedFile(file, isFront, isProfile);
      },
    );
  }

  void _handlePickedFile(File? file, bool isFront, bool isProfile) {
    if (file == null) return;

    setState(() {
      if (isProfile) {
        profileImage = file;
      } else if (selectedDoc == "Citizenship") {
        if (isFront) {
          frontImage = file;
        } else {
          backImage = file;
        }
      } else {
        singleDocImage = file;
      }
    });
  }

  // ---------------- DOCUMENT BOTTOM SHEET ----------------

  void _showDocumentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return DocumentUploadBottomSheet(
          documentType: selectedDoc,
          frontImage: frontImage,
          backImage: backImage,
          singleImage: singleDocImage,
          onPickFront: () => _showSourcePicker(isFront: true),
          onPickBack: () => _showSourcePicker(isFront: false),
          onPickSingle: () => _showSourcePicker(isFront: true),
          onRemoveFront: () => setState(() => frontImage = null),
          onRemoveBack: () => setState(() => backImage = null),
          onRemoveSingle: () => setState(() => singleDocImage = null),
          onUpload: () {
            debugPrint("Upload document API here");
          },
        );
      },
    );
  }

  // ---------------- VALIDATION ----------------

  Future<void> _validateAndSubmit() async {
    final result = DocumentValidator.validate(
      selectedDoc: selectedDoc,
      profileImage: profileImage,
      frontImage: frontImage,
      backImage: backImage,
      singleDocImage: singleDocImage,
    );

    setState(() {
      docError = result.documentError;
      photoError = result.photoError;
    });

    if (result.isValid) {
      final documents = <Documents>[];

      if (selectedDoc == "Citizenship") {
        final frontUpload = await _cloudinary.uploadImage(frontImage!);
        final backUpload = await _cloudinary.uploadImage(backImage!);

        documents.addAll([
          Documents(
            fileName: "citizenship_front",
            fileType: "image",
            file: frontUpload['secure_url'],
          ),
          Documents(
            fileName: "citizenship_back",
            fileType: "image",
            file: backUpload['secure_url'],
          ),
        ]);
      } else {
        final singleUpload = await _cloudinary.uploadImage(singleDocImage!);

        documents.add(
          Documents(
            fileName: selectedDoc,
            fileType: "image",
            file: singleUpload['secure_url'],
          ),
        );
      }

      widget.user.documentType = DocumentType(
        type: selectedDoc,
        documents: documents,
      );

      final profileUpload = await _cloudinary.uploadImage(profileImage!);

      widget.user.photo = Documents(
        fileName: "profile_photo",
        fileType: "image",
        file: profileUpload['secure_url'],
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .update(widget.user.toJson());

      debugPrint("User saved successfully");

      RouteGenerator.navigateToPageWithoutStack(context, Routes.homeRoute);
    }
  }
}

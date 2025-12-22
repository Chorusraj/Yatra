import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yatra/features/add_place/bloc/add_place_bloc.dart';
import 'package:yatra/features/add_place/bloc/add_place_event.dart';
import 'package:yatra/features/add_place/bloc/add_place_state.dart';
import 'package:yatra/features/add_place/model/add_places.dart';
import 'package:yatra/features/widgets/custom_button.dart';
import 'package:yatra/features/widgets/custom_textform.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  String? destinationName;
  String? description;
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void submitPlace() {
    if (destinationName == null || destinationName!.trim().isEmpty) {
      showError("Please enter destination name");
      return;
    }

    if (description == null || description!.trim().isEmpty) {
      showError("Please enter description");
      return;
    }

    if (selectedImage == null) {
      showError("Please upload an image");
      return;
    }

    final place = AddPlace(
      destination: destinationName!.trim(),
      aboutDestination: description!.trim(),
    );

    context.read<AddPlacesBloc>().add(
      AddPlaceEvent(place: place, imageFile: selectedImage!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPlacesBloc, AddPlaceState>(
      listener: (context, state) {
        if (state is AddPlaceLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AddPlaceLoadedState) {
          // Close loader
          if (Navigator.canPop(context)) Navigator.pop(context);

          // Show success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Place added successfully!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          // Optional: reset form fields for next entry
          setState(() {
            destinationName = null;
            description = null;
            selectedImage = null;
          });
        }

        if (state is AddPlaceErrorState) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          showError(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Places",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Destination",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              CustomTextformfield(
                labelText: "Enter the destination name",
                onChanged: (val) => destinationName = val,
              ),

              const SizedBox(height: 16),

              const Text(
                "About the Destination",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              CustomTextformfield(
                labelText: "Brief description of the destination",
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                onChanged: (val) => description = val,
              ),

              const SizedBox(height: 16),

              const Text(
                "Upload Image",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.upload_outlined,
                              size: 32,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text("Tap to upload image"),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 40),

              BlocBuilder<AddPlacesBloc, AddPlaceState>(
                builder: (context, state) {
                  final isLoading = state is AddPlaceLoadingState;

                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      backgroundColor: const Color(0xFF3D8DB5),
                      onPressed: isLoading ? null : submitPlace,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Proceed",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

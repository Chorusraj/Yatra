import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/core/services/cloudinary_service.dart';
import 'package:yatra/features/add_place/bloc/add_place_event.dart';
import 'package:yatra/features/add_place/bloc/add_place_state.dart';
import 'package:yatra/features/add_place/model/add_places.dart';

class AddPlacesBloc extends Bloc<AddPlacesEvent, AddPlaceState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddPlacesBloc() : super(AddPlaceInitialState()) {
    on<AddPlaceEvent>((event, emit) async {
      emit(AddPlaceLoadingState());

      try {
        final imageData = await CloudinaryService().uploadImage(
          event.imageFile,
        );

        await firestore.collection('places').add({
          ...event.place.toJson(),
          'url': imageData['secure_url'],
          'public_id': imageData['public_id'],
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(AddPlaceLoadedState());
      } catch (e) {
        emit(AddPlaceErrorState(e.toString()));
      }
    });
  }
}

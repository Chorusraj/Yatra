import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/core/services/cloudinary_service.dart';
import 'package:yatra/features/add_place/bloc/add_place_event.dart';
import 'package:yatra/features/add_place/bloc/add_place_state.dart';
import 'package:yatra/features/add_place/model/add_places.dart';

class AddPlacesBloc extends Bloc<AddPlacesEvent, AddPlacesState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddPlacesBloc() : super(AddPlacesInitialState()) {
    on<AddPlaceEvent>((event, emit) async {
      emit(AddPlacesLoadingState());

      try {
        // Upload image
        final imageData = await CloudinaryService().uploadImage(
          event.imageFile,
        );

        final docRef = await firestore.collection('places').add({
          'destination': event.place.destination,
          'about_destination': event.place.aboutDestination,
          'url': imageData['secure_url'],
          'public_id': imageData['public_id'],
          'createdAt': FieldValue.serverTimestamp(),
        });

        //  Store ID inside
        await docRef.update({'id': docRef.id});

        emit(AddPlacesLoadedState());
      } catch (e) {
        emit(AddPlacesErrorState(e.toString()));
      }
    });

    on<UpdatePlaceEvent>((event, emit) async {
      emit(AddPlacesLoadingState());

      try {
        String? imageUrl;
        String? publicId;

        if (event.imageFile != null) {
          final imageData = await CloudinaryService().uploadImage(
            event.imageFile!,
          );
          imageUrl = imageData['secure_url'];
          publicId = imageData['public_id'];
        }

        await firestore.collection('places').doc(event.place.id).update({
          'destination': event.place.destination,
          'about_destination': event.place.aboutDestination,
          if (imageUrl != null) 'url': imageUrl,
          if (publicId != null) 'public_id': publicId,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        emit(AddPlacesLoadedState());
      } catch (e) {
        emit(AddPlacesErrorState(e.toString()));
      }
    });
  }
}

class GetPlacesBloc extends Bloc<GetPlacesEvent, GetPlacesState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetPlacesBloc() : super(GetPlacesInitialState()) {
    on<FetchPlacesEvent>((event, emit) async {
      emit(GetPlacesLoadingState());

      try {
        final snapshot = await firestore
            .collection('places')
            .orderBy('createdAt', descending: true)
            .get();

        final places = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return AddPlace.fromJson({'id': doc.id, ...data});
        }).toList();

        emit(GetPlacesLoadedState(places));
      } catch (e) {
        emit(GetPlacesErrorState(e.toString()));
      }
    });

    /// 🔹 REMOVE PLACE FROM UI (OPTIMISTIC DELETE)
    on<RemovePlaceFromUIEvent>((event, emit) {
      if (state is GetPlacesLoadedState) {
        final currentState = state as GetPlacesLoadedState;
        final updatedPlaces = currentState.places
            .where((place) => place.id != event.placeId)
            .toList();
        emit(GetPlacesLoadedState(updatedPlaces));
      }
    });
  }
}

class DeletePlaceBloc extends Bloc<DeletePlaceEvent, DeletePlaceState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DeletePlaceBloc() : super(DeletePlaceInitialState()) {
    on<DeletePlaceByIdEvent>((event, emit) async {
      emit(DeletePlaceLoadingState());

      try {
        await firestore.collection('places').doc(event.placeId).delete();

        emit(DeletePlaceSuccessState(event.placeId));
      } catch (e) {
        emit(DeletePlaceErrorState(e.toString()));
      }
    });
  }
}

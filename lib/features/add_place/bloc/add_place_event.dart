import 'dart:io';
import 'package:yatra/features/add_place/model/add_places.dart';

abstract class AddPlacesEvent {}

// ADD PLACE
class AddPlaceEvent extends AddPlacesEvent {
  final AddPlace place;
  final File imageFile;

  AddPlaceEvent({required this.place, required this.imageFile});
}

// UPDATE PLACE
class UpdatePlaceEvent extends AddPlacesEvent {
  final AddPlace place;
  final File? imageFile;

  UpdatePlaceEvent({required this.place, this.imageFile});
}

// GET PLACES
abstract class GetPlacesEvent {}

class FetchPlacesEvent extends GetPlacesEvent {}

class RemovePlaceFromUIEvent extends GetPlacesEvent {
  final String placeId;
  RemovePlaceFromUIEvent(this.placeId);
}

// DELETE PLACE
abstract class DeletePlaceEvent {}

class DeletePlaceByIdEvent extends DeletePlaceEvent {
  final String placeId;
  DeletePlaceByIdEvent(this.placeId);
}

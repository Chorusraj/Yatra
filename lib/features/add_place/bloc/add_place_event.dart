import 'dart:io';

import 'package:yatra/features/add_place/model/add_places.dart';

abstract class AddPlacesEvent {}

class AddPlaceEvent extends AddPlacesEvent {
  final AddPlace place;
  final File imageFile;

  AddPlaceEvent({required this.place, required this.imageFile});
}

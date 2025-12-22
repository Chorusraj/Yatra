abstract class AddPlaceState {}

class AddPlaceInitialState extends AddPlaceState {}

class AddPlaceLoadingState extends AddPlaceState {}

class AddPlaceLoadedState extends AddPlaceState {}

class AddPlaceErrorState extends AddPlaceState {
  final String message;
  AddPlaceErrorState(this.message);
}

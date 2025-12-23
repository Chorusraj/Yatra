import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/features/add_place/bloc/add_place_bloc.dart';
import 'package:yatra/features/add_place/bloc/add_place_event.dart';
import 'package:yatra/features/add_place/bloc/add_place_state.dart';
import 'package:yatra/features/add_place/pages/add_places.dart';
import '../model/add_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetPlacesBloc()..add(FetchPlacesEvent())),
        BlocProvider(create: (_) => DeletePlaceBloc()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          title: const Text("Places"),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocListener<DeletePlaceBloc, DeletePlaceState>(
          listener: (context, state) {
            if (state is DeletePlaceSuccessState) {
              context.read<GetPlacesBloc>().add(
                RemovePlaceFromUIEvent(state.placeId),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Place deleted successfully"),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: BlocBuilder<GetPlacesBloc, GetPlacesState>(
            builder: (context, state) {
              if (state is GetPlacesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetPlacesLoadedState) {
                if (state.places.isEmpty) {
                  return const Center(
                    child: Text(
                      "No places added yet",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.places.length,
                  itemBuilder: (context, index) {
                    final AddPlace place = state.places[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// IMAGE + TITLE OVERLAY
                          if (place.url != null)
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    place.url!,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.2),
                                        Colors.black.withOpacity(0.6),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  bottom: 16,
                                  right: 16,
                                  child: Text(
                                    place.destination,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          /// CONTENT
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place.aboutDestination,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                /// ACTION BUTTONS
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => AddPlacesScreen(
                                              placeToEdit: place,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      label: const Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text(
                                              "Delete this place?",
                                            ),
                                            content: const Text(
                                              "This action cannot be undone.",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  context
                                                      .read<DeletePlaceBloc>()
                                                      .add(
                                                        DeletePlaceByIdEvent(
                                                          place.id!,
                                                        ),
                                                      );
                                                },
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      label: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),

        /// FAB
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          icon: const Icon(Icons.add),
          label: const Text("Add Place"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddPlacesScreen()),
            );
          },
        ),
      ),
    );
  }
}

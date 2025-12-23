class AddPlace {
  final String destination;
  final String aboutDestination;
  final String? url;
  final String? id;

  AddPlace({
    required this.destination,
    required this.aboutDestination,
    this.url,
    this.id,
  });

  factory AddPlace.fromJson(Map<String, dynamic> json) {
    return AddPlace(
      destination: json['destination'],
      aboutDestination: json['about_destination'],
      url: json['url'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'about_destination': aboutDestination,
      'url': url,
      'id': id,
    };
  }
}

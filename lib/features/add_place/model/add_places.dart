class AddPlace {
  final String destination;
  final String aboutDestination;
  final String? url;

  AddPlace({
    required this.destination,
    required this.aboutDestination,
    this.url,
  });

  factory AddPlace.fromJson(Map<String, dynamic> json) {
    return AddPlace(
      destination: json['destination'],
      aboutDestination: json['about_destination'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'about_destination': aboutDestination,
      'url': url,
    };
  }
}

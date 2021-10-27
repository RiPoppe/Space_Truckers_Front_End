class Data {
  final double distance;
  final int numberStars;
  final double mass;
  final double temperature;
  final double radius;
  Data({
    required this.distance,
    required this.numberStars,
    required this.mass,
    required this.temperature,
    required this.radius,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      distance: json['distance'],
      numberStars: json['number_stars'],
      mass: json['star_mass'],
      radius: json['star_temp'],
      temperature: json['star_radius'],
    );
  }
}

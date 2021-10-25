class Planet {
  final String name;
  final int planetId;
  final int x;
  final int y;
  Planet({
    required this.name,
    required this.planetId,
    required this.x,
    required this.y,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      planetId: json['planetId'],
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'X': x,
        'Y': y,
      };
}

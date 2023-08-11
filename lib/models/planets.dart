class Planet {
  final String id;
  final String name;
  final String location;
  final String distance;
  final String gravity;
  final String description;
  final String image;
  final String picture;

  const Planet({
    required this.id,
    required this.name,
    required this.location,
    required this.distance,
    required this.gravity,
    required this.description,
    required this.image,
    required this.picture,
  });
}

List<Planet> planets = [
  const Planet(
      id: "1",
      name: "#24042005Tt@",
      location: "Khu vực đường Ngô Quyền",
      distance: "54.6m Km",
      gravity: "3.711 m/s ",
      description:
          "Vận hành quanh tuyến đường Ngô Quyền",
      image: "assets/imgs/mars.png",
      picture:
          "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21723-16.jpg"),
  ];

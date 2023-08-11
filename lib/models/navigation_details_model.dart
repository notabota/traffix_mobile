class CarNavigationDetailsModel {
  String distance;
  String eta;
  List<String> road;
  String? note1;
  String? note2;

  CarNavigationDetailsModel({
    required this.distance,
    required this.eta,
    this.road = const [],
    this.note1,
    this.note2,
  });
}

class BusNavigationDetailsModel {
  String distance;
  String eta;
  String arrived;
  bool ticketPrice;
  String? note1;
  String? note2;

  BusNavigationDetailsModel({
    required this.distance,
    required this.eta,
    required this.arrived,
    required this.ticketPrice,
    this.note1,
    this.note2,
  });
}

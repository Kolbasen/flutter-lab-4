class PackageModel {
  final int id;
  final bool status;
  final int price;
  final String place;
  final DateTime date;

  PackageModel({this.id, this.status, this.place, this.date, this.price});

  factory PackageModel.parseJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      status: json['status'],
      price: json['price'],
      place: json['place'],
      date: DateTime.parse(json['date']),
    );
  }
}

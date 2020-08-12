import 'package:birthday_discovery/models/famousPerson.dart';


class FamousPeople {
  final List<FamousPerson> records;

  FamousPeople({this.records});

  factory FamousPeople.fromJson(Map<String, dynamic> json) {
    return FamousPeople(
      records:(json["births"] as List).map((i) =>
          FamousPerson.fromJson(i)).toList(),
    );
  }
}
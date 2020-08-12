import 'package:birthday_discovery/models/famousEvent.dart';

class FamousEvents {
  final List<FamousEvent> records;

  FamousEvents({this.records});

  factory FamousEvents.fromJson(Map<String, dynamic> json) {
    return FamousEvents(
      records:(json["events"] as List).map((i) =>
          FamousEvent.fromJson(i)).toList(),
    );
  }
}
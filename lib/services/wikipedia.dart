import '../models/famousPeople.dart';
import '../models/famousEvents.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WikipediaAPI {

  Future<FamousPeople> fetchBirths(DateTime dateTime) async {
    var date = formatDate(dateTime, [mm, '/', dd]);
    var response =
    await http.get("https://en.wikipedia.org/api/rest_v1/feed/onthisday/births/$date");

    if (response.statusCode == 200) {
      return FamousPeople.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Person');
    }
  }


  Future<FamousEvents> fetchEvents(DateTime dateTime) async {
    var date = formatDate(dateTime, [mm, '/', dd]);
    var response =
    await http.get("https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$date");

    if (response.statusCode == 200) {
      return FamousEvents.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Person');
    }
  }

}

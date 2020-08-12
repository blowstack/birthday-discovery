import 'package:flutter/material.dart';
import '../services/wikipedia.dart';

class WikipediaProvider with ChangeNotifier {
  int _events;
  int _people;
  DateTime date;
  final wikipediaAPI = WikipediaAPI();

  WikipediaProvider();

  get eventsCounter {
    return this._events;
  }

  get peopleCounter {
    return this._people;
  }

  set birthDate(DateTime date) {
    this.date = date;
  }

  get birthDate {
    return this.date;
  }

  setEventsCount() async {
    var length =  await wikipediaAPI.fetchEvents(birthDate);
    this._events =  length.records.length;
    notifyListeners();
  }

  setPeopleCount() async {
    var length =  await wikipediaAPI.fetchBirths(birthDate);
    this._people =  length.records.length;
    notifyListeners();
  }

}
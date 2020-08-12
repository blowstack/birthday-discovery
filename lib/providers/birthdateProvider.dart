import 'package:flutter/material.dart';
import '../models/birthDate.dart';

class BirthDateProvider with ChangeNotifier {
  BirthDate _birthDate;

  BirthDate get birthDate {
    return this._birthDate;
  }

  set birthDate(date) {

    this._birthDate = BirthDate(dateTime: date);
    notifyListeners();
  }

}
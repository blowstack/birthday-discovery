import 'package:flutter/material.dart';
import 'dart:async';

class BirthDateTimerProvider with ChangeNotifier {
  int _timeSecondsString = 0;
  int _timeMinutesString = 0;

  int _secondsFromBirth = 0;
  int _minutesFromBirth = 0;
  Timer secondTimer;
  Timer minutesTimer;

  void start() {
    secondTimer = new Timer.periodic(
        Duration(seconds: 1), (Timer t) => _getCurrentSeconds());
    minutesTimer = new Timer.periodic(
        Duration(minutes: 1), (Timer t) => _getCurrentMinutes());

    notifyListeners();
  }

  void _getCurrentSeconds() {
    _timeSecondsString += 1;
    notifyListeners();
  }

  void _getCurrentMinutes() {
    _timeMinutesString += 1;
    notifyListeners();
  }

  void reset() {
    _timeSecondsString = 0;
    _timeMinutesString = 0;
    _secondsFromBirth = 0;
    _minutesFromBirth = 0;

    secondTimer.cancel();
    minutesTimer.cancel();

    notifyListeners();
  }

  void update(date) {
    _secondsFromBirth = DateTime.now().difference(date).inSeconds;

    _timeSecondsString = _secondsFromBirth + _timeSecondsString;

    _minutesFromBirth = DateTime.now().difference(date).inMinutes;

    _timeMinutesString = _minutesFromBirth + _timeMinutesString;

    notifyListeners();
  }

  int get birthDateSeconds {
    return _timeSecondsString;
  }

  int get birthDateMinutes {
    return _timeMinutesString;
  }
}

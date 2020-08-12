import 'package:flutter/foundation.dart';
import 'package:date_format/date_format.dart';


class BirthDate {
  final DateTime dateTime;

  BirthDate({
    @required this.dateTime,
  });

  String getDateYear() {
    return dateTime != null ? formatDate(dateTime, [yyyy]) : '';
  }

  String getDateDayMonth() {
    return dateTime != null ? formatDate(dateTime, [dd, ' ', MM]) : '';
  }

  String getDateDayMonthShort() {
    return dateTime != null ? formatDate(dateTime, [d, ' ', MM]) : '';
  }

  String getWeekDate() {
    return dateTime != null ? formatDate(dateTime, [DD]) : '';
  }
}
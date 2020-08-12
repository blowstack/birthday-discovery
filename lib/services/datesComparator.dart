import 'package:flutter/foundation.dart';


class DatesComparator {
  final DateTime userDate;
  final DateTime entityDate;

  DatesComparator ({
    @required this.userDate,
    @required this.entityDate
  });

 int compareDays() {
      return userDate.difference(entityDate).inDays;
  }

  Map personDaysStatus() {

       final int daysDifference = this.compareDays();

       return {
         "message": daysDifference > 0 ? 'Born before You' : 'Born after you',
         "counter": daysDifference.abs(),
       };
  }

  Map eventDaysStatus() {

    final int daysDifference = this.compareDays();

    return {
      "message": daysDifference > 0 ? 'Before Your birth' : 'After Your birth',
      "counter": daysDifference.abs(),
    };
  }





}
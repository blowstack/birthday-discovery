import 'package:birthday_discovery/models/birthDate.dart';
import 'package:birthday_discovery/providers/birthdateProvider.dart';
import 'package:birthday_discovery/providers/birthdateTimeProvider.dart';
import 'package:flutter/material.dart';
import 'package:birthday_discovery/widgets/dashboardItemWidget.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class LifeTimeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final birthDatesData = Provider.of<BirthDateProvider>(context);
    final BirthDate birthDate = birthDatesData.birthDate;
    final birthTimer = Provider.of<BirthDateTimerProvider>(context);

    final hoursFromBirth =
        DateTime.now().difference(birthDate.dateTime).inHours;

    final daysFromBirth = DateTime.now().difference(birthDate.dateTime).inDays;

    final jiffy = Jiffy([
      birthDate.dateTime.year,
      birthDate.dateTime.month,
      birthDate.dateTime.day
    ]);


    final weeksFromBirth = jiffy.diff(DateTime.now(), Units.WEEK);
    final monthsFromBirth = jiffy.diff(DateTime.now(), Units.MONTH);
    final yearsFromBirth = jiffy.diff(DateTime.now(), Units.YEAR);
    final numberFormatter = NumberFormat('###,###,###,###,###', 'en_US');

    return           Container(
        margin: EdgeInsets.only(top: 30.0),
        width: double.infinity,
        child: Row(children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text("Life time",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  DashboardItemWidget(birthTimer.birthDateSeconds, ' seconds', 32, numberFormatter),
                  DashboardItemWidget(birthTimer.birthDateMinutes, ' minutes', 30, numberFormatter),
                  DashboardItemWidget(hoursFromBirth, ' hours', 28, numberFormatter),
                  DashboardItemWidget(daysFromBirth, ' days', 26, numberFormatter),
                  DashboardItemWidget(weeksFromBirth.abs(), ' weeks', 24, numberFormatter),
                  DashboardItemWidget(monthsFromBirth.abs(), ' months', 22, numberFormatter),
                  DashboardItemWidget(yearsFromBirth.abs(), ' years', 20, numberFormatter),
                ],
              ),
            ),
          ),
        ]));
  }
}

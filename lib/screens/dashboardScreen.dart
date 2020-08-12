import 'package:birthday_discovery/widgets/lifeTimeWidget.dart';
import 'package:birthday_discovery/widgets/sharedBottomNavigation.dart';
import 'package:birthday_discovery/widgets/zodiacWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../models/birthDate.dart';
import '../widgets/sharedAppBar.dart';
import 'package:provider/provider.dart';
import '../providers/birthdateProvider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final birthDatesData = Provider.of<BirthDateProvider>(context);
    final BirthDate birthDate = birthDatesData.birthDate;
    final String birthWeekDay = birthDate.getWeekDate();

    final jiffy = Jiffy([
      birthDate.dateTime.year,
      birthDate.dateTime.month,
      birthDate.dateTime.day
    ]);

    final dayOfTheYear = jiffy.dayOfYear;

    final weekOfTheYear = jiffy.week;

    return Scaffold(
        appBar: SharedAppBar(),
        bottomNavigationBar: SharedBottomNavigation(),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
//            width: double.infinity,
            child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ZodiacWidget(birthDate.dateTime, 'western'),
                    Text(
                      "${birthDate.getDateDayMonthShort()} ${birthDate.dateTime.year}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    ZodiacWidget(birthDate.dateTime, 'chinese'),
                  ],
                )),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Day',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center),
                          Text("$dayOfTheYear",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Day of the week',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center),
                          Text("$birthWeekDay",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Week',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center),
                          Text("$weekOfTheYear",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              LifeTimeWidget()
        ])));
  }
}

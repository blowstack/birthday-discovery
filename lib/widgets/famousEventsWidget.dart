import 'package:flutter/material.dart';
import '../providers/birthdateProvider.dart';
import 'package:provider/provider.dart';
import 'package:birthday_discovery/models/birthDate.dart';
import 'package:birthday_discovery/services/datesComparator.dart';

class FamousEventsWidget extends StatelessWidget {

  final event;
  final birthDate;

  FamousEventsWidget(this.event, this.birthDate);

  String cutString(String text) {
    const maxLen = 200;
    return text.length > maxLen
        ? text.replaceRange(maxLen, text.length, '...')
        : text;
  }

  @override
  Widget build(BuildContext context) {


    final BirthDate userBirthDate = Provider.of<BirthDateProvider>(context).birthDate;

    final BirthDate famouseventBirthDate = BirthDate(
        dateTime: new DateTime(
          event.year,
          userBirthDate.dateTime.month,
          userBirthDate.dateTime.day,
          userBirthDate.dateTime.hour,
          userBirthDate.dateTime.minute,
          userBirthDate.dateTime.second,
        )
    );

    final DatesComparator comparator = DatesComparator(
        userDate: userBirthDate.dateTime,
        entityDate: famouseventBirthDate.dateTime
    );

    final Map daysStatus = comparator.eventDaysStatus();

    return SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              child: Container(
                  padding: EdgeInsets.only( top: 25, bottom: 20.0),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "${famouseventBirthDate.getDateDayMonthShort()} ${famouseventBirthDate.dateTime.year}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black
                        ),
                      ),
                    ],
                  )
              )
          ),
          Container(
            margin:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "${event.thumbnail}",
                    ),
                    fit: BoxFit.contain)),
          ),
          Container(
              margin: EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.all(15),
              width: 400,
              child: Column(children: <Widget>[
                Text("${event.title}", textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
              ])),

          Container(
            margin: EdgeInsets.only(top: 5.0),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("${daysStatus['message']}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "${daysStatus['counter']} days",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Happened on',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center),
                          Text(famouseventBirthDate.getWeekDate(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5.0),
              width: double.infinity,
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("${event.extract}",
                          style: TextStyle(
                              fontSize: 16
                          ),
                          textAlign: TextAlign.justify,)
                    )
                ),
              ]))
        ])
    );
  }
}
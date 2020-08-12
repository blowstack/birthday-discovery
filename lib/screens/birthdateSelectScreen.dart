import 'package:birthday_discovery/providers/wikipediaProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import '../providers/birthdateProvider.dart';
import '../providers/birthdateTimeProvider.dart';

class BirthdaySelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final birthDateData = Provider.of<BirthDateProvider>(context);
    final birthDateTime = Provider.of<BirthDateTimerProvider>(context);
    final wikipediaData = Provider.of<WikipediaProvider>(context);

    print( Localizations.localeOf(context).languageCode);
    // start counting seconds from the app starting point
    void _selectBirthDay() {
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime(1900, 1, 1),
          maxTime: DateTime.now(), onConfirm: (date) {
        birthDateData.birthDate = date;
        birthDateTime.start();
        birthDateTime.update(date);
        wikipediaData.birthDate = date;
        wikipediaData.setEventsCount();
        wikipediaData.setPeopleCount();
        Navigator.pushReplacementNamed(context, '/Dashboard');
      }, currentTime: DateTime.now(), locale: LocaleType.en);
    }

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/splash-screen.jpg"),
        fit: BoxFit.cover,
      )),
      child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 300.0),
              child: Align(
                child: FlatButton(
                  padding: EdgeInsets.all(7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.purple,
                  child: Text(
                    'Select Birth Date',
                    style: TextStyle(fontSize: 22, color: Colors.white70),
                  ),
                  onPressed: _selectBirthDay,
                ),
              ),
            ))
          ]),
    ));
  }
}

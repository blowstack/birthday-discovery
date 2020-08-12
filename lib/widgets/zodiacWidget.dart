import 'package:birthday_discovery/screens/zodiacScreen.dart';
import 'package:birthday_discovery/widgets/circularLoaderWidget.dart';
import 'package:flutter/material.dart';
import 'package:birthday_discovery/models/birthDate.dart';
import 'package:birthday_discovery/services/datesComparator.dart';
import '../providers/birthdateProvider.dart';
import 'package:provider/provider.dart';
import 'package:birthday_discovery/services/zodiac.dart';

class ZodiacWidget extends StatelessWidget {

  final birthdate;
  final zodiacSignType;

  Future<Map> zodiacSign;

  ZodiacWidget(this.birthdate, this.zodiacSignType);

  @override
  Widget build(BuildContext context) {

    final Zodiac zodiac = Zodiac(dateTime: birthdate);

    final zodiacSign = zodiac.getSign(zodiacSignType);

    return FutureBuilder<Map>(
      future: zodiacSign,
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ZodiacScreen(snapshot.data, zodiacSignType))),
                  child: Image.asset(
                      "assets/images/${snapshot.data['name']}.png",
                      width: 80),
                )
              ],
            ),
          );
        }
        return CircularLoaderWidget(20,20, 5);
      },
    );
  }
}

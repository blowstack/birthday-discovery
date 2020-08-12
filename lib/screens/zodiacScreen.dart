import 'package:birthday_discovery/widgets/sharedBottomNavigation.dart';
import 'package:birthday_discovery/widgets/singleAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZodiacScreen extends StatelessWidget {
  final zodiac;
  final zodiacType;

  ZodiacScreen(this.zodiac, this.zodiacType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SingleAppBar(),
        bottomNavigationBar: SharedBottomNavigation(),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Image.asset("assets/images/${zodiac['name']}.png", width: 140),
          ]),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  zodiac['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                zodiacType.toString() + ' astrology',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              )),
            ],
          ),
          Container(
              padding: EdgeInsets.all(25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      zodiac['description'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    )
                  ]))
        ])));
  }
}

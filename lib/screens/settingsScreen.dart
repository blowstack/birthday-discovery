import 'package:birthday_discovery/providers/birthdateTimeProvider.dart';
import 'package:birthday_discovery/widgets/sharedBottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../widgets/sharedAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

_gotToUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Can\'t open this url now';
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final providerTimer = Provider.of<BirthDateTimerProvider>(context);

    return Scaffold(
        appBar: SharedAppBar(),
        bottomNavigationBar: SharedBottomNavigation(),
        body: ListView(padding: EdgeInsets.all(10), children: [
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black)),
            child: ListTile(
              leading: Icon(Icons.cake),
              title: Text('Select a new birth date'),
              onTap: () {
                providerTimer.reset();
                return Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black)),
            child: ListTile(
              leading: Icon(Icons.public),
              title: Text('Developer website'),
              onTap: () {
                const url = 'https://blowstack.com';
                _gotToUrl(url);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black)),
            child: ListTile(
              leading: Icon(Icons.attach_file),
              title: Text('Privacy policy (external source)'),
              onTap: () {
                const url =
                    'https://blowstack.com/portfolio/birthday-discovery-a-mobile-app-for-families-privacy.pdf';
                _gotToUrl(url);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black)),
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit the app'),
              onTap: () => SystemNavigator.pop(),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 30),
              color: Color.fromRGBO(54, 54, 54, 1),
              child: Column(children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 30, bottom: 10, left: 30, right: 30),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                "This is an open source app. The whole code is available on",
                            style: TextStyle(
                              fontSize: double.parse(14.toString()),
                            )),
                        TextSpan(
                            text: ' a GitHub public repository.',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url =
                                    'https://github.com/blowstack/birthday-discovery';
                                _gotToUrl(url);
                              }),
                        TextSpan(
                            text:
                                ' If you are interested in participating or creating your own app contact me through the website or GitHub.',
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 0, left: 35, right: 35, bottom: 35),
                  child: Image.asset("assets/images/blowstack-logo.png",
                      width: 180),
                ),
              ]))
        ]));
  }
}

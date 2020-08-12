import 'package:birthday_discovery/providers/wikipediaProvider.dart';
import 'package:birthday_discovery/screens/birthdateSelectScreen.dart';
import 'package:birthday_discovery/screens/comparisionScreen.dart';
import 'package:birthday_discovery/screens/dashboardScreen.dart';
import 'package:birthday_discovery/screens/famousEventsScreen.dart';
import 'package:birthday_discovery/screens/famousPeopleScreen.dart';
import 'package:birthday_discovery/screens/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/birthdateProvider.dart';
import 'providers/birthdateTimeProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => BirthDateProvider()),
          ChangeNotifierProvider(create: (ctx) => BirthDateTimerProvider()),
          ChangeNotifierProvider(create: (ctx) => WikipediaProvider())
    ],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
//            const Locale('pl', 'PL'),
            const Locale('en', 'US'),
          ],
      routes: <String, WidgetBuilder>{
        '/': (context) => BirthdaySelectScreen(),
        '/Dashboard': (context) => DashboardScreen(),
        '/Events': (context) => FamousEventsScreen(),
        '/People': (context) => FamousPeopleScreen(),
        '/Comparision': (context) => ComparisionScreen(),
        '/Settings': (context) => SettingsScreen(),
      },
    ));
  }
}

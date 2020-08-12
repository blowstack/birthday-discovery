import 'package:birthday_discovery/providers/wikipediaProvider.dart';
import 'package:birthday_discovery/widgets/circularLoaderWidget.dart';
import 'package:birthday_discovery/widgets/famousEventsWidget.dart';
import 'package:birthday_discovery/widgets/sharedBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../models/famousEvents.dart';
import '../services/wikipedia.dart';
import '../widgets/sharedAppBar.dart';
import 'package:provider/provider.dart';
import '../providers/birthdateProvider.dart';
import 'package:birthday_discovery/models/birthDate.dart';

class FamousEventsScreen extends StatefulWidget {
  @override
  _FamousEventsScreenState createState() => _FamousEventsScreenState();
}

class _FamousEventsScreenState extends State<FamousEventsScreen> {
  Future<FamousEvents> futureFamousEvents;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final birthDatesData = Provider.of<BirthDateProvider>(context);
    final wikipediaData = Provider.of<WikipediaProvider>(context);
    final counter = wikipediaData.eventsCounter;
    final wikipediaAPI = WikipediaAPI();

    BirthDate birthDate = birthDatesData.birthDate;

    futureFamousEvents = wikipediaAPI.fetchEvents(birthDatesData.birthDate.dateTime);

    return Scaffold(
        appBar: SharedAppBar(),
        bottomNavigationBar: SharedBottomNavigation(),
        body: PageView.builder(
          itemCount: counter,
            controller: pageController,
            itemBuilder: (context, position) {
              return FutureBuilder<FamousEvents>(
                  future: futureFamousEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
//                    if (snapshot.hasData && snapshot.data.records.indexOf(snapshot.data.records.last) >= position) {
                      return FamousEventsWidget(
                          snapshot.data.records[position], birthDate);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularLoaderWidget(50, 50, 5);
                  });
            })
    );
  }
}

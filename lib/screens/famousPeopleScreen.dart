import 'package:birthday_discovery/models/famousPeople.dart';
import 'package:birthday_discovery/providers/wikipediaProvider.dart';
import 'package:birthday_discovery/widgets/circularLoaderWidget.dart';
import 'package:birthday_discovery/widgets/famousPeopleWidget.dart';
import 'package:birthday_discovery/models/birthDate.dart';
import 'package:birthday_discovery/widgets/sharedBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../services/wikipedia.dart';
import '../widgets/sharedAppBar.dart';
import 'package:provider/provider.dart';
import '../providers/birthdateProvider.dart';

class FamousPeopleScreen extends StatefulWidget {
  @override
  _FamousPeopleScreenState createState() => _FamousPeopleScreenState();
}

class _FamousPeopleScreenState extends State<FamousPeopleScreen> {

  Future<FamousPeople> futureFamousPeople;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage:0);
  }

  @override
  Widget build(BuildContext context) {

    final birthDatesData = Provider.of<BirthDateProvider>(context);
    final wikipediaData = Provider.of<WikipediaProvider>(context);
    final counter = wikipediaData.peopleCounter;
    final wikipediaAPI = WikipediaAPI();

    BirthDate birthDate = birthDatesData.birthDate;

    futureFamousPeople = wikipediaAPI.fetchBirths(birthDate.dateTime);

    return Scaffold(
        appBar: SharedAppBar(),
        bottomNavigationBar: SharedBottomNavigation(),
        body: PageView.builder(
          itemCount: counter,
          controller: pageController,
            itemBuilder: (context, position) {
              return FutureBuilder<FamousPeople>(
                  future: futureFamousPeople,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return  FamousPeopleWidget(snapshot.data.records[position], birthDate);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularLoaderWidget(50, 50, 5);
                  });
            }
        )
    );
  }
}
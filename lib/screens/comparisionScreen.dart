import 'package:birthday_discovery/services/worldBank.dart';
import 'package:birthday_discovery/widgets/comparisionWidget.dart';
import 'package:birthday_discovery/widgets/sharedBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/birthDate.dart';
import '../widgets/sharedAppBar.dart';
import 'package:provider/provider.dart';
import '../providers/birthdateProvider.dart';

class ComparisionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final birthDatesData = Provider.of<BirthDateProvider>(context);
    BirthDate birthDate = birthDatesData.birthDate;

    Future currentTotalPopulation;
    Future birthTotalPopulation;

    Future currentPopulationDensity;
    Future birthPopulationDensity;

    Future currentGdpGrowth;
    Future birthdateGdpGrowth;

    Future currentGdpTotal;
    Future birthdateGdpTotal;

    Future currentCoEmission;
    Future birthdateCoEmission;

    final WorldBankAPI worldBankAPI = WorldBankAPI();

    currentTotalPopulation =
        worldBankAPI.fetchTotalPopulation(year: DateTime.now().year, futureCounter: true);
    birthTotalPopulation =
        worldBankAPI.fetchTotalPopulation(year: birthDate.dateTime.year, futureCounter: false);

    currentPopulationDensity =
        worldBankAPI.fetchPopulationDensity(DateTime.now().year);
    birthPopulationDensity =
        worldBankAPI.fetchPopulationDensity(birthDate.dateTime.year);

    currentGdpGrowth = worldBankAPI.fetchGdpGrowth(year: DateTime.now().year);
    birthdateGdpGrowth = worldBankAPI.fetchGdpGrowth(year: birthDate.dateTime.year);

    currentGdpTotal = worldBankAPI.fetchGdpTotal(year: DateTime.now().year,  futureCounter: true);
    birthdateGdpTotal = worldBankAPI.fetchGdpTotal(year: birthDate.dateTime.year, futureCounter: false);

    currentCoEmission = worldBankAPI.fetchCoEmission(year: DateTime.now().year, futureCounter: true);
    birthdateCoEmission = worldBankAPI.fetchCoEmission(year: birthDate.dateTime.year, futureCounter: false);

    final numberFormatter = NumberFormat('###,###,###,###,###', 'en_US');
    final percentFormatter = NumberFormat('###.##', 'en_US');
    final decimalFormatter = NumberFormat.decimalPattern('en_US');

    return Scaffold(
        appBar: SharedAppBar(),
        bottomNavigationBar: SharedBottomNavigation(),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 17, bottom: 17),
//            color: Colors.black,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('${birthDate.dateTime.year}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Image.asset(
                      "assets/images/versus.png",
                      width: 80),
                  Text('${DateTime.now().year}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ]),
          ),
          ComparisionWidget('Total population', '', birthTotalPopulation,
              currentTotalPopulation, true, numberFormatter),
          ComparisionWidget(
              'Population density',
              'person/square meter',
              birthPopulationDensity,
              currentPopulationDensity,
              false,
              decimalFormatter),
          ComparisionWidget('Gross global product', 'total in US \$',
              birthdateGdpTotal, currentGdpTotal, true, numberFormatter),
          ComparisionWidget('Gross global product', 'growth rate %',
              birthdateGdpGrowth, currentGdpGrowth, false, percentFormatter),
          ComparisionWidget('CO2 emission', 'tones/year',  birthdateCoEmission,
              currentCoEmission, true, numberFormatter),
        ])));
  }
}

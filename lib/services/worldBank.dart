
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldBankAPI {

  final int secondsFromJanuary = DateTime(DateTime.now().year, 1, 1)
      .difference(DateTime.now())
      .inSeconds
      .abs();

  final int secondsInYear = DateTime(DateTime.now().year, 1, 1)
      .difference(DateTime(DateTime.now().year, 12, 31))
      .inSeconds
      .abs();

  final int milliSecondsFromJanuary = DateTime(DateTime.now().year, 1, 1)
      .difference(DateTime.now())
      .inMilliseconds
      .abs();

  final int milliSecondsInYear = DateTime(DateTime.now().year, 1, 1)
      .difference(DateTime(DateTime.now().year, 12, 31))
      .inMilliseconds
      .abs();



  Future fetchTotalPopulation({int year, futureCounter = false}) async {

    year = year < 1960 ? 1960 : year;
    String yearsSpan = futureCounter == true ? '$year:${year + 1}' : year.toString();

    var response =
    await http.get("http://api.worldbank.org/v2/country/wld/indicator/sp.pop.totl/?format=json&source=40&date=$yearsSpan");

    if (response.statusCode == 200 && futureCounter ) {

      var values = json.decode(response.body)[1];
      var futureValue = values[0]['value'];
      var currentValue = values[1]['value'];

      var valuePerSecond = ((futureValue - currentValue) / secondsInYear);
      var startValue = currentValue + valuePerSecond * secondsFromJanuary;
      int frequencyChange = 1000;

      return  {
        'start': startValue.toInt(),
        'step': valuePerSecond.toInt(),
        'frequency': frequencyChange
      };

    }
    else if(response.statusCode == 200 ) {

      var values = json.decode(response.body)[1];

      return values[0]['value'];

    }
    else {
      throw Exception('Failed to fetch data');
    }
  }

  Future fetchPopulationDensity(int year) async {

    year = year < 1961 ? 1961 : year;
    year = year > 2018 ? 2018 : year;

    var response =
    await http.get("http://api.worldbank.org/v2/country/wld/indicator/en.pop.dnst?format=json&date=$year");

    if (response.statusCode == 200 ) {

      var values = json.decode(response.body)[1];

      return values[0]['value'];

    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future fetchGdpGrowth({int year}) async {

    year = year < 1961 ? 1961 : year;
    year = year == DateTime.now().year ? DateTime.now().year - 1 : year;

    var response =
    await http.get("http://api.worldbank.org/v2/country/wld/indicator/ny.gdp.mktp.kd.zg/?format=json&date=$year");

    if (response.statusCode == 200 ) {

      var values = json.decode(response.body)[1];

      return values[0]['value'];

    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future fetchGdpTotal({int year, futureCounter = false}) async {

    year = year < 1961 ? 1961 : year;
    year = year == DateTime.now().year ? DateTime.now().year - 1 : year;
    String yearsSpan = futureCounter == true ? '$year:${year - 1}' : year.toString();

    var response =
    await http.get("http://api.worldbank.org/v2/country/wld/indicator/ny.gdp.mktp.cd/?format=json&date=$yearsSpan");

    if (response.statusCode == 200 && futureCounter ) {

      var values = json.decode(response.body)[1];
      var currentValue = values[0]['value'];
      var pastValue = values[1]['value'];

      var valuePerSecond = ((currentValue - pastValue) / milliSecondsInYear);
      var startValue = currentValue / milliSecondsInYear * milliSecondsFromJanuary;
      int frequencyChange = 1;

      return  {
        'start': startValue.toInt(),
        'step': valuePerSecond.toInt(),
        'frequency': frequencyChange
      };

    }
    else if(response.statusCode == 200 ) {

      var values = json.decode(response.body)[1];

      return values[0]['value'];

    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future fetchCoEmission({int year, futureCounter = false}) async {

    year = year < 1960 ? 1960 : year;
    year = year > 2014 ? 2014 : year;
    String yearsSpan = futureCounter == true ? '$year:${year - 1}' : year.toString();

    var response =
    await http.get("http://api.worldbank.org/v2/country/wld/indicator/en.atm.co2e.kt?format=json&date=$yearsSpan");

    if (response.statusCode == 200 && futureCounter ) {

      var values = json.decode(response.body)[1];
      var currentValue = values[0]['value'];

      var valuePerSecond = ((currentValue ) / secondsInYear);
      var startValue = valuePerSecond * secondsFromJanuary;
      int frequencyChange = 1000;

      return  {
        'start': startValue.toInt(),
        'step': valuePerSecond.toInt(),
        'frequency': frequencyChange
      };

    }
    else if(response.statusCode == 200 ) {

      var values = json.decode(response.body)[1];

      return values[0]['value'];

    } else {
      throw Exception('Failed to fetch data');
    }
  }

}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

class Zodiac {
  final Set signTypes = {
    "western",
    "chinese",
  };

  DateTime dateTime;
  String locale;

  Zodiac({@required this.dateTime, this.locale = 'en'});

  DateTime get date {
    return this.dateTime;
  }

  set date(DateTime date) {
    this.dateTime = date;
  }

  Future<int> convertYearToChinese(DateTime dateTime) async {

    final int year = dateTime.year;
    final int month = dateTime.month;
    final int day = dateTime.day;

    var response =
    await http.get("https://pteo.paranoiaworks.mobi/chinese_calendar/cncalprov.php?g2c=1&year=$year&month=$month&date=$day");

    if (response.statusCode == 200) {

      final Xml2Json xml2Json = Xml2Json();
      final xml = response.body;

      xml2Json.parse(xml);

      final json = jsonDecode(xml2Json.toParker());

      return int.parse(json['ROOT']['YEAR']);
    } else {
      return dateTime.year;
    }

  }

  Future<Map> getSignsMap(String signType) async {
    String content;

    try {
      content = await rootBundle
          .loadString('assets/zodiac/${signType}/${this.locale}.json');
    }
    catch (e) {
      throw (e);
    }

    return jsonDecode(content);
  }

  Future<Map> getSign(String signType) async {

    if (this.signTypes.lookup(signType) == null) {
      throw ('no such sign type available');
    }

    Map sign;

    switch (signType) {
      case 'western':
        sign = await this.gregorianSignNames;
        break;
      case 'chinese':
        sign = await this.chineseSignNames;
        break;
      default:
        throw ('no such sign type available');
    }

    return sign;
  }

  composeSignNames(signsMap, String signName) {
    return {
      'name': signsMap[signName]['name'],
      'nativeName': signName,
      'description': signsMap[signName]['description'],
    };
  }

  Future<Map> get gregorianSignNames async {

    Map sign;
    final int month = this.dateTime.month;
    final int day = this.dateTime.day;
    final signsMap = await this.getSignsMap('western');


    switch(month) {
      case 1:
        if (day < 20) sign = this.composeSignNames(signsMap, 'Capricorn');
        else sign = this.composeSignNames(signsMap, 'Aquarius');
        break;
      case 2:
        if (day < 20) sign = this.composeSignNames(signsMap, 'Aquarius');
        else sign = this.composeSignNames(signsMap, 'Pisces');
        break;
      case 3:
        if (day < 21) sign = this.composeSignNames(signsMap, 'Pisces');
        else sign =  this.composeSignNames(signsMap, 'Aries');
        break;
      case 4:
        if (day < 21) sign = this.composeSignNames(signsMap, 'Aries');
        else sign = this.composeSignNames(signsMap, 'Taurus');
        break;
      case 5:
        if (day < 21) sign = this.composeSignNames(signsMap, 'Taurus');
        else sign = this.composeSignNames(signsMap, 'Gemini');
        break;
      case 6:
        if (day < 21) sign = this.composeSignNames(signsMap, 'Gemini');
        else sign = this.composeSignNames(signsMap, 'Cancer');
        break;
      case 7:
        if (day < 23) sign = this.composeSignNames(signsMap, 'Cancer');
        else sign = this.composeSignNames(signsMap, 'Leo');
        break;
      case 8:
        if (day < 23) sign = this.composeSignNames(signsMap, 'Leo');
        else sign = this.composeSignNames(signsMap, 'Virgo');
        break;
      case 9:
        if (day < 23) sign = this.composeSignNames(signsMap, 'Virgo');
        else sign = this.composeSignNames(signsMap, 'Libra');
        break;
      case 10:
        if (day < 23) sign = this.composeSignNames(signsMap, 'Libra');
        else sign = this.composeSignNames(signsMap, 'Scorpio');
        break;
      case 11:
        if (day < 23) sign = this.composeSignNames(signsMap, 'Scorpio');
        else sign = this.composeSignNames(signsMap, 'Sagittarius');
        break;
      case 12:
        if (day < 23) sign = this.composeSignNames(signsMap, 'Sagittarius');
        else sign = this.composeSignNames(signsMap, 'Capricorn');
        break;
    }
    return sign;
  }

  Future<Map> get chineseSignNames async {

    Map sign;
    final signsMap = await this.getSignsMap('chinese');
    final int year = await this.convertYearToChinese(this.dateTime);

    switch(year % 12) {
      case 0: sign = this.composeSignNames(signsMap, 'Monkey'); break;
      case 1: sign = this.composeSignNames(signsMap, 'Rooster'); break;
      case 2: sign = this.composeSignNames(signsMap, 'Dog'); break;
      case 3: sign = this.composeSignNames(signsMap, 'Pig'); break;
      case 4: sign = this.composeSignNames(signsMap, 'Rat'); break;
      case 5: sign = this.composeSignNames(signsMap, 'Ox'); break;
      case 6: sign = this.composeSignNames(signsMap, 'Tiger'); break;
      case 7: sign = this.composeSignNames(signsMap, 'Rabbit'); break;
      case 8: sign = this.composeSignNames(signsMap, 'Dragon'); break;
      case 9: sign = this.composeSignNames(signsMap, 'Snake'); break;
      case 10: sign = this.composeSignNames(signsMap, 'Horse'); break;
      case 11: sign = this.composeSignNames(signsMap, 'Goat'); break;
    }

    return sign;
  }

}

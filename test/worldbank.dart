import 'package:birthday_discovery/services/worldBank.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';

void main() {
  test('fetching data', () async {

    final WorldBankAPI wordBankAPI = WorldBankAPI();
    Future<dynamic> totalPopulationFetch = wordBankAPI.fetchTotalPopulation(year: 1900);
    var totalPopulationData = await totalPopulationFetch;

    print(totalPopulationData);

  });
}

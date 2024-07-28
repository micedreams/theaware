import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/model/country_and_states.dart';

void main() {
  group('filterCountryAndStates', () {
    test('returns an empty list when no countries match the string', () {
      final list = [
        CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
        CountryAndStates(country: 'USA', states: ['California', 'Texas']),
      ];

      final result = filterCountryAndStates(list, 'xyz');

      expect(result, isEmpty);
    });

    test('returns matching countries when there are matches', () {
      final list = [
        CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
        CountryAndStates(country: 'USA', states: ['California', 'Texas']),
      ];

      final result = filterCountryAndStates(list, 'ind');

      expect(result.length, 1);
      expect(result[0].country, 'India');
    });

    test('is case insensitive', () {
      final list = [
        CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
        CountryAndStates(country: 'USA', states: ['California', 'Texas']),
      ];

      final result = filterCountryAndStates(list, 'InD');

      expect(result.length, 1);
      expect(result[0].country, 'India');
    });

    test('returns multiple matches', () {
      final list = [
        CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
        CountryAndStates(country: 'Indonesia', states: ['Jakarta', 'Bali']),
        CountryAndStates(country: 'USA', states: ['California', 'Texas']),
      ];

      final result = filterCountryAndStates(list, 'ind');

      expect(result.length, 2);
      expect(result[0].country, 'India');
      expect(result[1].country, 'Indonesia');
    });
  });
}

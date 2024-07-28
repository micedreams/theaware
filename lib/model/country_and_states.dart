import 'package:flutter/foundation.dart';

class CountryAndStates {
  final String country;
  final List<String> states;

  CountryAndStates({required this.country, required this.states});

  @override
  String toString() => 'CountryAndStates(country: $country, states: $states)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAndStates &&
          runtimeType == other.runtimeType &&
          country == other.country &&
          listEquals(states, other.states);

  @override
  int get hashCode => country.hashCode ^ states.hashCode;
}

List<CountryAndStates> filterCountryAndStates(
        List<CountryAndStates> list, String string) =>
    list
        .where(
            (item) => item.country.toLowerCase().contains(string.toLowerCase()))
        .toList();

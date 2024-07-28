import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/country_and_states.dart';


Future<List<CountryAndStates>> readFromFile(AssetBundle bundle) async {
  // Read the file contents as a string
  final contents = await bundle.loadString('assets/country_state.json');

  // Decode the JSON string into a Dart object
  final jsonData = json.decode(contents);

  // Transform the JSON data into a list of CountryAndStates objects
  return jsonData.map<CountryAndStates>((map) {
    final country = map.keys.first;
    final states = List<String>.from(map[country]);
    return CountryAndStates(country: country, states: states);
  }).toList();
}

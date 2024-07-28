import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:theaware_screen/helper/read_from_file.dart';
import 'package:theaware_screen/model/country_and_states.dart';

import 'read_from_file_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  final mockBundle = MockAssetBundle();

  group('readFromFile', () {
    test(
        'returns a list of CountryAndStates when the file is read successfully',
        () async {
      // Define the mock JSON data
      const mockJsonData = '''
      [
        {"India": ["Delhi", "Karnataka"]},
        {"USA": ["California", "Texas"]}
      ]
      ''';

      // Mock the loadString method to return the mock JSON data
      when(mockBundle.loadString('assets/country_state.json'))
          .thenAnswer((_) async => mockJsonData);

      // Call the readFromFile function
      final result = await readFromFile(mockBundle);

      // Define the expected result
      final expected = [
        CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
        CountryAndStates(country: 'USA', states: ['California', 'Texas']),
      ];

      // Verify the result
      expect(result.length, expected.length);
      for (int i = 0; i < result.length; i++) {
        expect(result[i].country, expected[i].country);
        expect(result[i].states, expected[i].states);
      }
    });

    test('throws an exception when the file content is invalid JSON', () async {
      // Define invalid mock JSON data
      const mockInvalidJsonData = '''
      invalid json data
      ''';

      // Mock the loadString method to return the invalid mock JSON data
      when(mockBundle.loadString('assets/country_state.json'))
          .thenAnswer((_) async => mockInvalidJsonData);

      // Call the readFromFile function and expect an exception
      expect(() => readFromFile(mockBundle), throwsA(isA<FormatException>()));
    });
  });
}

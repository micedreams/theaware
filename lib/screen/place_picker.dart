import 'package:flutter/material.dart';
import 'package:theaware_screen/model/gender.dart';

import '../../main.dart';
import '../../model/country_and_states.dart';
import '../widgets/a_text_field.dart';

class PlacePicker extends StatefulWidget {
  final TextEditingController stateController;

  final TextEditingController countryController;

  const PlacePicker({
    super.key,
    required this.stateController,
    required this.countryController,
  });

  @override
  State createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  final filteredCountries = ValueNotifier(<CountryAndStates>[]);
  final filteredStates = ValueNotifier(<String>[]);
  ValueNotifier<Gender?> selectedGenderNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    widget.countryController.addListener(() => onFilterCountries(allCountries));
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ATextField(
              label: 'Country',
              controller: widget.countryController,
            ),
          ),
          ValueListenableBuilder<List<CountryAndStates>>(
            key: const Key('filteredCountries'),
            valueListenable: filteredCountries,
            builder: (context, value, _) => CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: value.length,
                    (context, index) => ListTile(
                      title: Text(value[index].country),
                      onTap: () => onTapCountry(value[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ATextField(
              label: 'State',
              controller: widget.stateController,
            ),
          ),
          ValueListenableBuilder<List<String>>(
            key: const Key('filteredStates'),
            valueListenable: filteredStates,
            builder: (context, value, _) => CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: value.length,
                    (context, index) => ListTile(
                      title: Text(value[index]),
                      onTap: () => onTapState(value[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  void onFilterCountries(List<CountryAndStates> allCountries) {
    final query = widget.countryController.text.toLowerCase();

    widget.stateController.text = "";
    filteredStates.value = [];

    filteredCountries.value = filterCountryAndStates(allCountries, query);
  }

  void onTapCountry(CountryAndStates value) {
    widget.countryController.text = value.country;

    filteredCountries.value.clear();

    if (filteredCountries.value.isEmpty) {
      filteredStates.value = value.states;
    }
  }

  void onTapState(String state) {
    widget.stateController.text = state;

    filteredStates.value.clear();
  }
}

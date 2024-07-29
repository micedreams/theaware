import 'package:flutter/material.dart';
import '../../../../model/country_and_states.dart';
import '../../../../widgets/a_text_field.dart';
import '../../../helper/multi_value_listnable_builder.dart';
import '../../../widgets/a_sliver_list.dart';

class PlacePicker extends StatefulWidget {
  final TextEditingController stateController;
  final TextEditingController countryController;
  final List<CountryAndStates> allCountries;

  const PlacePicker({
    super.key,
    required this.stateController,
    required this.countryController,
    required this.allCountries,
  });

  @override
  State createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  final filteredCountries = ValueNotifier(<CountryAndStates>[]);
  final filteredStates = ValueNotifier(<String>[]);

  @override
  void initState() {
    super.initState();
    widget.countryController.addListener(onFilterCountries);
  }

  @override
  void dispose() {
    widget.countryController.removeListener(onFilterCountries);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiValueListenableBuilder(
        valueListenables: [filteredCountries, filteredStates],
        builder: (context, _) {
          final filteredStatesValue = filteredStates.value;
          final filteredCountriesValue = filteredCountries.value;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: ATextField(
                  label: 'Country',
                  controller: widget.countryController,
                ),
              ),
              filteredCountriesValue.isEmpty
                  ? const SizedBox.shrink()
                  : ASliverList(
                      key: const Key('filteredCountries'),
                      childCount: filteredCountriesValue.length,
                      buildLabel: (index) =>
                          filteredCountriesValue[index].country,
                      onTap: (index) =>
                          onTapCountry(filteredCountriesValue[index]),
                    ),
              if (filteredCountriesValue.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: ATextField(
                    label: 'State',
                    controller: widget.stateController,
                  ),
                ),
              filteredStatesValue.isEmpty
                  ? const SizedBox.shrink()
                  : ASliverList(
                      key: const Key('filteredStates'),
                      childCount: filteredStatesValue.length,
                      buildLabel: (index) => filteredStatesValue[index],
                      onTap: (index) =>
                          onTapState(filteredStatesValue[index]),
                    ),
            ],
          );
        },
      );

  void onFilterCountries() {
    widget.stateController.text = "";
    filteredStates.value = [];

    final query = widget.countryController.text.toLowerCase();

    filteredCountries.value =
        filterCountryAndStates(widget.allCountries, query);
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

    filteredStates.value = [];
  }
}

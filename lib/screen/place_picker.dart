import 'package:flutter/material.dart';
import '../../model/country_and_states.dart';
import '../../widgets/a_text_field.dart';

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
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
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
              builder: (context, value, _) {
                if (value.isEmpty) return const SizedBox.shrink();

                return ASliverList(
                  childCount: value.length,
                  buildLabel: (index) => value[index].country,
                  onTap: (index) => onTapCountry(value[index]),
                );
              },
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
              builder: (context, value, _) {
                if (value.isEmpty) return const SizedBox.shrink();

                return ASliverList(
                  childCount: value.length,
                  buildLabel: (index) => value[index],
                  onTap: (index) => onTapState(value[index]),
                );
              },
            ),
          ],
        ),
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

class ASliverList extends StatelessWidget {
  const ASliverList({
    super.key,
    required this.childCount,
    required this.buildLabel,
    required this.onTap,
  });
  final int childCount;
  final String Function(int) buildLabel;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(),
        child: CustomScrollView(
          slivers: [
            SliverList.separated(
              itemCount: childCount,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(buildLabel(index)),
                onTap: () => onTap(index),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}

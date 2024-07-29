import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theaware_screen/model/country_and_states.dart';
import 'package:theaware_screen/screen/onboarding/widgets/gender_picker.dart';
import 'package:theaware_screen/widgets/a_text_field.dart';

import '../../helper/multi_value_listnable_builder.dart';
import '../../model/gender.dart';
import 'widgets/onboarding_widget.dart';
import 'widgets/place_picker.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key, required this.allCountries});

  final List<CountryAndStates> allCountries;

  @override
  State createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageNotifier = ValueNotifier(1);
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  final dateNotifier = ValueNotifier(DateTime.now());
  final ValueNotifier<Gender?> genderNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: MultiValueListenableBuilder(
                valueListenables: [
              pageNotifier,
              nameController,
              dateController,
              genderNotifier,
            ],
                builder: (context, _) {
                  switch (pageNotifier.value) {
                    case 1:
                      return OnboardingWidget(
                        pageNotifier: pageNotifier,
                        title: 'What should we call you?',
                        subtitle:
                            "Pick a pen name, or use your real one, it's your adventure!",
                        showNext: nameController.text.isNotEmpty,
                        child: ATextField(
                            label: 'Name', controller: nameController),
                      );
                    case 2:
                      return OnboardingWidget(
                        pageNotifier: pageNotifier,
                        title: 'When’s your birthday?',
                        subtitle:
                            "Just a little info to help us tailor your experience. No time travel required!",
                        child: ATextField(
                          label: 'Date',
                          controller: dateController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: dateNotifier.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              dateNotifier.value = pickedDate;

                              dateController.text =
                                  DateFormat('d MMM yyyy').format(pickedDate);
                            }
                          },
                        ),
                        onSkip: () {
                          dateController.clear();
                          dateNotifier.value = DateTime.now();
                        },
                      );
                    case 3:
                      return OnboardingWidget(
                        pageNotifier: pageNotifier,
                        title: 'What gender do you identify with?',
                        subtitle:
                            'We celebrate diversity and respect your identity.',
                        child: GenderPicker(
                            selectedGenderNotifier: genderNotifier),
                        onSkip: () => genderNotifier.value = null,
                      );
                    case 4:
                      return OnboardingWidget(
                        pageNotifier: pageNotifier,
                        title: 'Where are you from?',
                        subtitle:
                            "Setting the scene for your story. Which part of the world are you joining us from?",
                        child: PlacePicker(
                            stateController: stateController,
                            countryController: countryController,
                            allCountries: widget.allCountries),
                        onSkip: () {
                          stateController.clear();
                          countryController.clear();
                        },
                      );
                    default:
                      return const SizedBox();
                  }
                })),
      );
}

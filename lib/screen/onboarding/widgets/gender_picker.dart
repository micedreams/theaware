import 'package:flutter/material.dart';
import 'package:theaware_screen/helper/a_constants.dart';
import 'package:theaware_screen/helper/string_extension.dart';

import '../../../model/gender.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({super.key, required this.selectedGenderNotifier});
  final ValueNotifier<Gender?> selectedGenderNotifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        key: const Key('GenderPicker'),
        valueListenable: selectedGenderNotifier,
        builder: (context, gender, _) => ListView.builder(
          shrinkWrap: true,
          itemCount: Gender.values.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => selectedGenderNotifier.value = Gender.values[index],
            child: Container(
              // Note: this was not hugging so this is just what looked ok
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: gender == Gender.values[index]
                    ? AConstants.genderPickerBoxColorActive
                    : AConstants.genderPickerBoxColor,
                border: Border.all(
                  color: gender == Gender.values[index]
                      ? AConstants.genderPickerBoxBorderColorActive
                      : AConstants.genderPickerBoxBorderColor,
                  width: gender == Gender.values[index]
                      ? AConstants.genderPickerBoxBorderWidthActive
                      : AConstants.genderPickerBoxBorderWidth,
                ),
                borderRadius: BorderRadius.circular(
                  AConstants.genderPickerBoxBorderRadius,
                ),
              ),
              child: Text(
                Gender.values[index].name.splitCamelCaseToString().capitalize(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AConstants.genderPickerFontSize,
                  fontWeight: AConstants.genderPickerFontWeight,
                ),
              ),
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

import '../helper/a_constants.dart';

class ATextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const ATextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => TextField(
        key: Key(label),
        controller: controller,
        cursorColor: AConstants.aTextFieldcursorColor,
        decoration: InputDecoration(hintText: label),
      );
}

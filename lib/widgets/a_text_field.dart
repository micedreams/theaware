import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../helper/a_constants.dart';

class ATextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback? onTap;

  const ATextField({
    super.key,
    required this.label,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => TextField(
      onTap: onTap,
      readOnly: onTap != null,
      key: Key(label),
      controller: controller,
      cursorColor: AConstants.aTextFieldcursorColor,
      decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: 'Mulish',
              color: Color(0xff8F90A6))),
      style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          fontFamily: 'Mulish',
          color: Color(0xff3A3A3C)));
}

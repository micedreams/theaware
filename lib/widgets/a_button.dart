import 'package:flutter/material.dart';

class AButton extends StatelessWidget {
  const AButton({
    super.key,
    required this.label,
    required this.backGroundColor,
    required this.labelColor,
    this.onTap,
  });
  final String label;
  final Color backGroundColor;
  final Color labelColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            color: labelColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  factory AButton.primary({
    required String label,
    required VoidCallback onTap,
  }) =>
      AButton(
        key: const Key('primaryButton'),
        backGroundColor: const Color(0xff27AE60),
        label: label,
        labelColor: const Color(0xffffffff),
        onTap: onTap,
      );

  factory AButton.secondary({
    required String label,
    required VoidCallback onTap,
  }) =>
      AButton(
        key: const Key('secondaryButton'),
        backGroundColor: const Color(0xffF2F2F5),
        label: label,
        labelColor: const Color(0xff3A3A3C),
        onTap: onTap,
      );

  factory AButton.disabled({required String label}) => AButton(
        key: const Key('disabledButton'),
        backGroundColor: const Color(0xffE3E3E3),
        label: label,
        labelColor: const Color(0xffffffff),
      );
}

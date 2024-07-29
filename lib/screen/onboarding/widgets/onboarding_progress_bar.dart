import 'package:flutter/material.dart';

import '../../../helper/a_constants.dart';

class OnboardingProgressBar extends StatelessWidget {
  const OnboardingProgressBar({
    super.key,
    required this.onBack,
    required this.progressBar,
  });
  final VoidCallback onBack;
  final double progressBar;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 9,
                endIndent: progressBar,
                color: AConstants.dividerColor,
              ),
              IconButton(
                onPressed: onBack,
                iconSize: 24.0,
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
        ],
      );
}

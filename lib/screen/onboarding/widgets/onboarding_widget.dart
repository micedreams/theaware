import 'package:flutter/material.dart';
import 'package:theaware_screen/model/user.dart';
import 'package:theaware_screen/screen/home.dart';

import '../../../widgets/a_button.dart';
import 'onboarding_progress_bar.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.pageNotifier,
    required this.title,
    required this.subtitle,
    required this.child,
    this.onSkip,
    this.user,
    this.showNext = true,
  });

  final ValueNotifier<int> pageNotifier;
  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback? onSkip;
  final bool showNext;
  final User? user;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OnboardingProgressBar(
            progressBar: MediaQuery.of(context).size.width *
                ((4 - pageNotifier.value) / 4),
            onBack: () => goToLastPage(context),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                  fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Mulish",
                  fontSize: 16),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: child,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                showNext
                    ? AButton.primary(
                        label: 'Next', onTap: () => goToNextPage(context))
                    : AButton.disabled(label: 'Next'),
                if (onSkip != null) const SizedBox(height: 4),
                if (onSkip != null)
                  AButton.secondary(
                    label: 'Skip',
                    onTap: () => onSkipPage(context),
                  ),
              ],
            ),
          )
        ],
      );

  void onSkipPage(BuildContext context) {
    onSkip?.call();
    goToNextPage(context);
  }

  void goToNextPage(BuildContext context) {
    if (pageNotifier.value < 4) {
      final page = pageNotifier.value;
      pageNotifier.value = page + 1;
    } else {
      Navigator.pushNamed(context, '/Home', arguments: HomeConfig(user: user));
    }
  }

  void goToLastPage(BuildContext context) {
    if (pageNotifier.value == 1) {
      Navigator.maybePop(context);
    } else {
      final page = pageNotifier.value;
      pageNotifier.value = page - 1;
    }
  }
}

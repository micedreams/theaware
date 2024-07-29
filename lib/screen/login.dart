import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/a_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Inter",
                            fontSize: 36),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Mirror is your compass on the journey of personal development.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Mulish",
                              fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Text(
                        'Reflect on experiences, gain insightful perspectives, and walk the path of self-discovery with awareness.',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Mulish",
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    AButton.primary(
                      label: 'Continue with Google',
                      onTap: () => goToNextPage(context),
                    ),
                    const SizedBox(height: 10),
                    AButton.secondary(
                      label: 'Continue with Apple',
                      onTap: () => goToNextPage(context),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Text(
                                "By clicking Continue, I accept Mirror's ",
                                style: TextStyle(
                                    fontFamily: 'Mulish', fontSize: 10)),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              key: const Key('Terms'),
                              onTap: onTerms,
                              child: const Text('Terms of Use',
                                  style: TextStyle(
                                      color: Color(0xff2072EF),
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'Mulish',
                                      fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  void onTerms() async {
    final Uri url = Uri.parse('https://www.google.com');

    await launchUrl(url);
  }

  void goToNextPage(BuildContext context) =>
      Navigator.pushNamed(context, '/Onboarding');
}

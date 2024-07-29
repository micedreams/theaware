import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theaware_screen/model/user.dart';

import '../widgets/a_button.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.config,
  });
  final HomeConfig config;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = widget.config.user;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thanks for onboarding',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",
                          fontSize: 36),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${user?.name ?? 'Not specified'}'),
                        Text('Gender:${user?.gender?.name ?? 'Not specified'}'),
                        Text(
                            'Birthday: ${user?.birthday != null ? DateFormat('dd MMM yyyy').format(user?.birthday ?? DateTime.now()) : 'Not specified'}'),
                        Text('Country: ${user?.country ?? 'Not specified'}'),
                        Text('State: ${user?.state ?? 'Not specified'}'),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  AButton.primary(
                    label: 'Go to start',
                    onTap: () => goToStart(context),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToStart(BuildContext context) =>
      Navigator.pushNamed(context, '/Login');
}

class HomeConfig {
  final User? user;

  HomeConfig({this.user});
}

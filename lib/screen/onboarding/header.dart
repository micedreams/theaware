import 'package:flutter/material.dart';

import '../../helper/a_constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.pageNotifier,
  });

  final ValueNotifier<int> pageNotifier;

  @override
  Widget build(BuildContext context) {
    final progressBar =
        MediaQuery.of(context).size.width * ((4 - pageNotifier.value) / 4);

    return Column(
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
              onPressed: () {
                if (pageNotifier.value == 1) {
                  Navigator.maybePop(context);
                } else {
                  final page = pageNotifier.value;
                  pageNotifier.value = page - 1;
                }
              },
              iconSize: 24.0,
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ],
        ),
      ],
    );
  }
}

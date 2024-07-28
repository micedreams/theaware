import 'package:flutter/material.dart';

class ASliverList extends StatelessWidget {
  const ASliverList({
    super.key,
    required this.childCount,
    required this.buildLabel,
    required this.onTap,
  });
  final int childCount;
  final String Function(int) buildLabel;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(),
        child: CustomScrollView(
          slivers: [
            SliverList.separated(
              itemCount: childCount,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(buildLabel(index)),
                onTap: () => onTap(index),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}

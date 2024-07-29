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
  Widget build(BuildContext context) => Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: const Color(0xffC7C9D9))),
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: childCount,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () => onTap(index),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(buildLabel(index)),
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                        color: Color(0xffC7C9D9), indent: 16, endIndent: 16),
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';

class TitleIndicatorWidget extends StatelessWidget {
  const TitleIndicatorWidget({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(title)
      ],
    );
  }
}

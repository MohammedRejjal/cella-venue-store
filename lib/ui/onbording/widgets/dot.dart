import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({
    Key? key,
    required this.x,
  }) : super(key: key);

  final bool x;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: x ? Theme.of(context).primaryColor : Colors.white54),
        ),
        Container(
          margin: EdgeInsets.all(3.5),
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: x ? Colors.white : Colors.black12),
        )
      ],
    );
  }
}

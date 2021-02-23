import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final Color color;

  const LogoWidget({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'lib/ui/assets/icons/icon.png',
          color: color,
          width: 55,
        ),
        SizedBox(height: 19),
        Text(
          'NEWS',
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 19,
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: color,
          ),
        ),
      ],
    );
  }
}

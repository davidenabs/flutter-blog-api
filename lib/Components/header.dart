import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String title;
  double fontSize;
  Header({
    super.key, required this.title, required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey, fontSize: fontSize),
    );
  }
}

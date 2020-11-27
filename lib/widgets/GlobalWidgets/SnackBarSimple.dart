import 'package:flutter/material.dart';

class SnackBarSimple extends StatelessWidget {
  final String title;
  SnackBarSimple(this.title);
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.amber,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}

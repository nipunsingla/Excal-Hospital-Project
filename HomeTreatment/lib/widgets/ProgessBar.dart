import 'package:flutter/material.dart';

class ProgessBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor:new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        
      ),
    );
  }
}

import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/blogComponent.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body:BlogComponent(),
    );
  }
}
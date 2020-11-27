import 'package:HomeTreatment/screens/HospitalRegister.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/MoreWidget.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Others', style: Theme.of(context).textTheme.headline4),
          MoreWidget(
            "Add Hospital",
            () {
              pushNewScreenWithRouteSettings(
                context,
                withNavBar: false,
                screen: HospitalRegister(),
                settings: RouteSettings(
                  name: HospitalRegister.routeName,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

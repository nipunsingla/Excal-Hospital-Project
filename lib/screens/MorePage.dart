import 'dart:io';

import 'package:HomeTreatment/screens/HomeScreen.dart';
import 'package:HomeTreatment/screens/HospitalRegister.dart';
import 'package:HomeTreatment/screens/myAppointmentScreen.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/MoreWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          MoreWidget(
            "My Appointments",
            () {
              pushNewScreenWithRouteSettings(
                context,
                withNavBar: false,
                screen: MyAppointmentScreen(),
                settings: RouteSettings(
                  name: MyAppointmentScreen.routeName,
                ),
              );
            },
          ),
          MoreWidget(
            "Logout",
            () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('token',null);
            SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}

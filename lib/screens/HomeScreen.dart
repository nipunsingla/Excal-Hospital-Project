import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:HomeTreatment/screens/MainScreen.dart';
import '../screens/SignUpScreen.dart';
import '../screens/LoginScreen.dart';

import 'package:HomeTreatment/provider/auth.dart';
import '../widgets/HomeScreenWidgets/HomeScreenButton.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void callPrefences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    Provider.of<Auth>(context, listen: false).setToken(token);
    if (token != null) {
      Navigator.of(context).pushNamed(MainScreen.routeName);
    }
  }

  void initState() {
    super.initState();
    callPrefences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: const Center(
                child: Icon(
                  Icons.local_hospital_rounded,
                  color: Colors.amber,
                  size: 60.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Medicare",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            HomeScreenButton("Sign Up", SignUpScreen.routeName),
            HomeScreenButton("Login", LoginScreen.routeName),
          ],
        ),
      ),
    );
  }
}

import 'package:HomeTreatment/model/patient.dart';
import 'package:HomeTreatment/model/serverData.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  PatientModel _p;
  String _token;
  Auth() {
    _p = new PatientModel("", "");
    print(_p);
    _token = '';
  }
  String getToken() {
    return _token;
  }

  Future<void> signUp(String name, String email, String contact,
      String password, String gender, String age) async {
    try {
      print("i am in auth");
      var response = await http
          .post(new Uri.http("10.0.2.2:3001", "/patient/register"), body: {
        "email": email,
        "name": name,
        "contact": contact,
        "gender": gender,
        "age": age,
        "password": password
      });
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var itemCount = jsonResponse['flag'];
      if (itemCount == 0) {
        print(jsonResponse['message']);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print(jsonResponse['message']);
        _token = jsonResponse['token'];
        await prefs.setString('token', _token);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}

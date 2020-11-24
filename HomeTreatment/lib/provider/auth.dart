import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/model/patientHospitalModel.dart';
import 'package:HomeTreatment/model/serverData.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import '../model/patientModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  PatientModel _p;
  String _token;
  bool _isAuth;
  Auth() {
    _p = new PatientModel("", "");
    print(_p);
    _token = '';
    _isAuth = false;
  }
  String getToken() {
    return _token;
  }

  bool isAuth() {
    return _isAuth;
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
        _isAuth = true;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      print("i am in auth");
      var response = await http.post(
          new Uri.http("10.0.2.2:3001", "/patient/login"),
          body: {"email": email, "password": password});
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
        _isAuth = true;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<HospitalModel>> getHospitalList() async {
    List<PatientHospitalModel> lm;
    List<HospitalModel> li = [
      HospitalModel("adj", "ndslf", "dsjkdf", "ndklfnd", "fklfnlkfns", lm),

      HospitalModel("adj", "ndslf", "dsjkdf", "ndklfnd", "fklfnlkfns", lm),

      HospitalModel("adj", "ndslf", "dsjkdf", "ndklfnd", "fklfnlkfns", lm),
    ];
    return li;
  }
}

import 'package:HomeTreatment/model/AppointmentList.dart';
import 'package:HomeTreatment/model/SymptomsMode.dart';
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
  HospitalModel selectedHospital;
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

  void setToken(String token) {
    print(token);
    this._token = token;
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
      var response = await http.post(new Uri.http("10.0.2.2:3001", "/login"),
          body: {"email": email, "password": password});
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var itemCount = jsonResponse['flag'];
      if (itemCount == 0) {
        print(jsonResponse['message']);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print(jsonResponse['message']);
        _token = jsonResponse['payload']['token'];
        await prefs.setString('token', _token);
        _isAuth = true;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<HospitalModel>> getAllHospitalList() async {
    try {
      List<PatientHospitalModel> lm;

      var response = await http.get(
          new Uri.http("10.0.2.2:3001", "/hospital/getAllHospitals"),
          headers: {'authorization': _token});
      var jsonResponse = jsonDecode(response.body);
      //print(jsonResponse);
      //print(jsonResponse['message']);

      if (jsonResponse['flag'] == 0) {
        return [];
      } else {
        List<HospitalModel> li = [];
        for (int i = 0; i < jsonResponse['payload'].length; i++) {
          var item = jsonResponse['payload'][i];
          print(item);
          HospitalModel temp = new HospitalModel(
              item['name'],
              item['city'],
              item['state'],
              item['imageUrl'],
              item['meetLink'],
              item['timings'],
              item['_id']);
          print("i am temp");
          print(temp);
          li.add(temp);
        }
        return li;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<AppointmentList>> getHospitalAppointmentList(String id) async {
    List<AppointmentList> lm;

    var response = await http.get(new Uri.http("10.0.2.2:3001", "/hospital/"),
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(jsonResponse['message']);

    if (jsonResponse['flag'] == 0) {
      return [];
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        AppointmentList li=new AppointmentList(jsonResponse['payload']['startTime'], jsonResponse['payload']['endTime'],jsonResponse['status']);
      lm.add(li);
      }
      return lm;
    }
  }

  Future<void> registerHospital(
      String name,
      String city,
      String state,
      String specs,
      String meetLink,
      String startTime,
      String endTime,
      String filename,
      String hospitalUrl) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://10.0.2.2:3001/hospital/registerHospital"));
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    request.fields['name'] = name;
    request.fields['city'] = city;
    request.fields['state'] = city;
    request.fields['specs'] = specs;
    request.fields['startTime'] = startTime;
    request.fields['endTime'] = endTime;
    request.fields['hospitalUrl'] = hospitalUrl;
    request.fields['meetLink'] = meetLink;
    request.headers['authorization'] = _token;
    var res = await request.send();
    print(res);
  }

  Future<List<SymptomsModel>> getListOfSymptoms() async {
    print("hello");
    List<SymptomsModel> li=[];
     var response = await http.get(new Uri.http("10.0.2.2:3001", "/getSymptomsList")
     ,headers: {
       'authorization':_token
     });
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print("i am in get hospital symptoms");
    print(jsonResponse['message']);

    if (jsonResponse['flag'] == 0) {
      return li;
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        print(jsonResponse['payload'][i]['ID']);
          SymptomsModel s1=new SymptomsModel(jsonResponse['payload'][i]['ID'],jsonResponse['payload'][i]['Name']);
        li.add(s1);
      }
      return li;
    }
  }   
  Future<void> getListOfIssues(List<int> arr){
    
  }


}

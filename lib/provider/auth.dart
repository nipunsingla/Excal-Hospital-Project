import 'package:HomeTreatment/model/AppointmentList.dart';
import 'package:HomeTreatment/model/ConsultantModel.dart';
import 'package:HomeTreatment/model/SymptomsMode.dart';
import 'package:HomeTreatment/model/blogModel.dart';
import 'package:HomeTreatment/model/hospitalModel.dart';
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
  String error = '';
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
      var response =
          await http.post("https://hospital-treatment.herokuapp.com/signup", body: {
        "email": email,
        "name": name,
        "contact": contact,
        "gender": gender,
        "age": age,
        "password": password
      });
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var itemCount = (jsonResponse['flag'] as int);
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
      var response = await http.post(("https://hospital-treatment.herokuapp.com/login"),
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
    List<HospitalModel> li = [];

    try {
      var response = await http.get(
          ("https://hospital-treatment.herokuapp.com/hospital/getAllHospitals"),
          headers: {'authorization': _token});
      var jsonResponse = jsonDecode(response.body);
      //print(jsonResponse);
      //print(jsonResponse['message']);

      if (jsonResponse['flag'] == 0) {
        return [];
      } else {
        for (int i = 0; i < jsonResponse['payload'].length; i++) {
          var item = jsonResponse['payload'][i];
          print(item);
          List<TimeModel> timeList = [];
          for (int j = 0;
              j < jsonResponse['payload'][i]['timings'].length;
              j++) {
            print(jsonResponse['payload'][i]['timings']);
            timeList.add(new TimeModel(
                jsonResponse['payload'][i]['timings'][j]['timeslotStart'],
                (jsonResponse['payload'][i]['timings'][j]['status'] as bool),
                jsonResponse['payload'][i]['timings'][j]['timeslotEnd']));
          }
          print(timeList);
          HospitalModel temp = new HospitalModel(
            item['name'],
            item['city'],
            item['state'],
            item['imageUrl'],
            item['meetLink'],
            (timeList),
            item['_id'],
          );
          print("i am temp");
          print(temp);
          li.add(temp);
        }
        return li;
      }
    } on Exception catch (e) {
      print(e);
    }
    return li;
  }

  Future<bool> makeAppointment(String id, String time) async {
    var response = await http.post(
        ("https://hospital-treatment.herokuapp.com/patient/makeAppointment"),
        headers: {'authorization': _token},
        body: {"hospitalId": id, "dateAndTime": time});
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(jsonResponse['message']);

    if (jsonResponse['flag'] == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<AppointmentList>> getHospitalAppointmentList(String id) async {
    List<AppointmentList> lm;

    var response = await http.get(("https://hospital-treatment.herokuapp.com/hospital/"),
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(jsonResponse['message']);

    if (jsonResponse['flag'] == 0) {
      return [];
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        AppointmentList li = new AppointmentList(
            jsonResponse['payload']['startTime'],
            jsonResponse['payload']['endTime'],
            jsonResponse['status']);
        lm.add(li);
      }
      return lm;
    }
  }

  Future<bool> registerHospital(
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
        'POST', Uri.parse("http://https://hospital-treatment.herokuapp.com/hospital/registerHospital"));
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    request.fields['name'] = name;
    request.fields['city'] = city;
    request.fields['state'] = state;
    request.fields['specs'] = specs;
    request.fields['startTime'] = startTime;
    request.fields['endTime'] = endTime;
    request.fields['hospitalUrl'] = hospitalUrl;
    request.fields['meetLink'] = meetLink;
    request.headers['authorization'] = _token;
    var res = await request.send();
    print(res);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ConsultantModel>> getAllConsultants() async {
    print("ndkdnksjfnjfjks");
    List<ConsultantModel> li = [];
    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/consultant/getAll"),
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);
    if (jsonResponse['flag'] == 0) {
      print("error");
      return [];
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        var x = jsonResponse['payload'][i];
        print(x);
        ConsultantModel cm = new ConsultantModel(x['consultantname'],
            x['consultantEmail'], x['consultantSpecialization']);
        li.add(cm);
      }
      return li;
    }
  }

  Future<List<SymptomsModel>> getListOfSymptoms() async {
    print("hello");
    List<SymptomsModel> li = [];
    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/getSymptomsList"),
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print("i am in get hospital symptoms");
    print(jsonResponse['message']);

    if (jsonResponse['flag'] == 0) {
      return li;
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        print(jsonResponse['payload'][i]['ID']);
        SymptomsModel s1 = new SymptomsModel(jsonResponse['payload'][i]['ID'],
            jsonResponse['payload'][i]['Name']);
        li.add(s1);
      }
      return li;
    }
  }

  Future<List<String>> getListOfIssues(List<int> arr) async {
    var response = await http.post(
        (
            "https://hospital-treatment.herokuapp.com/medic/getIssues"),

        headers: {'authorization': _token},
        body:{
          "symptoms":arr.toString()
        });
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    List<String> temp = [];
    for (int i = 0; i < jsonResponse['payload'].length; i++) {
      print("working");
      temp.add(jsonResponse['payload'][i]['Issue']['Name'].toString());
    }

    print(temp);
    return temp;
  }

  Future<List<BlogModel>> getBlogs() async {
    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/blog/readAll"),
        headers: {'authorization': _token});
    List<BlogModel> li = [];
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse['flag'] == 0) {
      print("some error in blog fetching");
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        BlogModel temp = new BlogModel(
            jsonResponse['payload'][i]['userName'],
            jsonResponse['payload'][i]['_id'],
            jsonResponse['payload'][i]['description'],
            jsonResponse['payload'][i]['title'],
            jsonResponse['payload'][i]['imageUrl']);
        li.add(temp);
      }
    }

    return li;
  }
}

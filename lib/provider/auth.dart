import 'package:HomeTreatment/model/AppointmentList.dart';
import 'package:HomeTreatment/model/ConsultantModel.dart';
import 'package:HomeTreatment/model/ErrorModel.dart';
import 'package:HomeTreatment/model/MyAppointmentModel.dart';
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
  String _mlToken = 'Token 35ff180760f42a815ddb97b01c1bdfaf6829f64c';
  Auth() {
    _p = new PatientModel("", "");
    //  print(_p);
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
    // print(token);
    this._token = token;
  }

  Future<ErrorModel> signUp(String name, String email, String contact,
      String password, String gender, String age) async {
    try {
      //  print("i am in sign up");
      var response = await http.post(
        "https://hospital-treatment.herokuapp.com/signup",
        body: {
          "email": email,
          "name": name,
          "contact": contact,
          "gender": gender,
          "age": age,
          "password": password
        },
      );
      var jsonResponse = jsonDecode(response.body);
      var flag = (jsonResponse['flag'] as int);
      if (flag == 0) {
        //    print(jsonResponse['message']);
        return ErrorModel(jsonResponse['message'], false);
      } else {
        //  print(jsonResponse['message']);
        return ErrorModel(jsonResponse['message'], true);
      }
    } on Exception catch (e) {
      //print(e);
      return ErrorModel("Some error try again later", false);
    }
  }

  Future<ErrorModel> login(String email, String password) async {
    try {
      //   print("i am in login");
      var response = await http.post(
        "https://hospital-treatment.herokuapp.com/login",
        body: {
          "email": email,
          "password": password,
        },
      );
      var jsonResponse = jsonDecode(response.body);
      var flag = jsonResponse['flag'];
      if (flag == 0) {
        return ErrorModel(jsonResponse['message'], false);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _token = jsonResponse['payload']['token'];
        await prefs.setString('token', _token);
        _isAuth = true;
        return ErrorModel(jsonResponse['message'], true);
      }
    } on Exception catch (e) {
      //  print(e);
      return ErrorModel("Some error try again later", false);
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
          //      print(item);
          List<TimeModel> timeList = [];
          for (int j = 0;
              j < jsonResponse['payload'][i]['timings'].length;
              j++) {
            //    print(jsonResponse['payload'][i]['timings']);
            timeList.add(new TimeModel(
                jsonResponse['payload'][i]['timings'][j]['timeslotStart'],
                (jsonResponse['payload'][i]['timings'][j]['status'] as bool),
                jsonResponse['payload'][i]['timings'][j]['timeslotEnd']));
          }
          //   print(timeList);
          HospitalModel temp = new HospitalModel(
            item['name'],
            item['city'],
            item['state'],
            item['imageUrl'],
            item['meetLink'],
            (timeList),
            item['_id'],
          );

          ///  print("i am temp");
          //print(temp);
          li.add(temp);
        }
        return li;
      }
    } on Exception catch (e) {
      // print(e);
    }
    return li;
  }

  Future<ErrorModel> makeAppointment(
      String id, String time, bool status) async {
    var response = await http.post(
        ("https://hospital-treatment.herokuapp.com/patient/makeAppointment"),
        headers: {
          'authorization': _token
        },
        body: {
          "hospitalId": id,
          "dateAndTime": time,
          "status": (status ? "true" : "false")
        });
    var jsonResponse = jsonDecode(response.body);

    ///  print(jsonResponse);
    // print(jsonResponse['message']);

    if (jsonResponse['flag'] == 0) {
      return new ErrorModel(jsonResponse['message'], false);
    } else {
      return new ErrorModel(jsonResponse['message'], true);
    }
  }

  Future<List<AppointmentList>> getHospitalAppointmentList(String id) async {
    List<AppointmentList> lm;

    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/hospital/"),
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);
    //  print(jsonResponse);
    // print(jsonResponse['message']);

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

  Future<ErrorModel> deleteBlogs(String id) async {
    var response = await http.post(
        "https://hospital-treatment.herokuapp.com/blog/delete",
        body: {'blogId': id},
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['flag'] == 1) {
      return new ErrorModel("SuccessFully Deleted", true);
    } else {
      return new ErrorModel(jsonResponse['message'], false);
    }
  }

  Future<ErrorModel> addBlogs(
      String title, String description, String filename) async {
    var request = http.MultipartRequest(

      'POST',
      Uri.parse("https://hospital-treatment.herokuapp.com/blog/create"),
    );
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    request.fields['blogTitle'] = title;
    request.fields['blogDesc'] = description;
    request.headers['authorization'] = _token;
    var res = await request.send();
    // print(res);
    if (res.statusCode == 200) {
      return new ErrorModel("SuccessFully Register", true);
    } else {
      return new ErrorModel("Unsucessfull", false);
    }
  }

  Future<List<String>> getSkinDiseases(String filename) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://54.197.95.62:8000/api/image-report/"),
    );
    request.files
        .add(await http.MultipartFile.fromPath('parsed_image', filename));
    request.headers['Authorization'] =
        'Token 35ff180760f42a815ddb97b01c1bdfaf6829f64c';
    var res = await request.send();
    print(res.statusCode);
    final respStr = await res.stream.bytesToString();

    print(respStr);
    List<String> li = [];
    if (res.statusCode == 200) {
      Map<String,dynamic> mp=jsonDecode(respStr);
      print(mp);
    } else {}
    return li;
  }

  Future<ErrorModel> registerHospital(
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
        'POST',
        Uri.parse(
            "https://hospital-treatment.herokuapp.com/hospital/registerHospital"));
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
    //  print(res);
    if (res.statusCode == 200) {
      return new ErrorModel("SuccessFully Register", true);
    } else {
      return new ErrorModel("Unsucessfull", false);
    }
  }

  Future<List<ConsultantModel>> getAllConsultants() async {
    // print("ndkdnksjfnjfjks");
    List<ConsultantModel> li = [];
    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/consultant/getAll"),
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);

    // print(jsonResponse);
    if (jsonResponse['flag'] == 0) {
      ///  print("error");
      return [];
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        var x = jsonResponse['payload'][i];

        ///  print(x);
        ConsultantModel cm = new ConsultantModel(x['consultantname'],
            x['consultantEmail'], x['consultantSpecialization']);
        li.add(cm);
      }
      return li;
    }
  }

  Future<List<SymptomsModel>> getListOfSymptoms() async {
    // print("hello");
    List<SymptomsModel> li = [];
    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/getSymptomsList"),
        headers: {'authorization': _token});
    var jsonResponse = jsonDecode(response.body);
    //print(jsonResponse);
    //print("i am in get hospital symptoms");
    //print(jsonResponse['message']);

    if (jsonResponse['flag'] == 0) {
      return li;
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        // print(jsonResponse['payload'][i]['ID']);
        SymptomsModel s1 = new SymptomsModel(jsonResponse['payload'][i]['ID'],
            jsonResponse['payload'][i]['Name']);
        li.add(s1);
      }
      return li;
    }
  }

  Future<List<String>> getListOfIssues(List<int> arr) async {
    var response = await http.post(
        ("https://hospital-treatment.herokuapp.com/medic/getIssues"),
        headers: {'authorization': _token},
        body: {"symptoms": arr.toString()});
    var jsonResponse = jsonDecode(response.body);
    //print(jsonResponse);
    List<String> temp = [];
    for (int i = 0; i < jsonResponse['payload'].length; i++) {
      // print("working");
      temp.add(jsonResponse['payload'][i]['Issue']['Name'].toString());
    }

    // print(temp);
    return temp;
  }

  Future<List<BlogModel>> getBlogs() async {
    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/blog/readAll"),
        headers: {'authorization': _token});
    List<BlogModel> li = [];
    var jsonResponse = jsonDecode(response.body);
    //  print(jsonResponse);
    if (jsonResponse['flag'] == 0) {
      //    print("some error in blog fetching");
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

  Future<List<MyAppointmentModel>> getMyAppointmentList() async {
    var response = await http.get(
        ("https://hospital-treatment.herokuapp.com/patient/getAllAppointments"),
        headers: {'authorization': _token});
    List<MyAppointmentModel> li = [];
    var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    if (jsonResponse['flag'] == 0) {
      // print("some error in Appointment fetching");
    } else {
      for (int i = 0; i < jsonResponse['payload'].length; i++) {
        var x = jsonResponse['payload'][i];
        MyAppointmentModel temp = new MyAppointmentModel(
            x['hospitalId'], x['appointmentDateAndTime'], x['status']);
        li.add(temp);

      }
    }
  print(li);
    return li;
  }
}

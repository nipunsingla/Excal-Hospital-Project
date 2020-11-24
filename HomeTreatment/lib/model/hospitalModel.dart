import 'package:HomeTreatment/model/patientHospitalModel.dart';
import 'package:HomeTreatment/model/patientModel.dart';

import './patientHospitalModel.dart';
class HospitalModel{
  String name;
  String city;
  String state;
  String meetLink;
  String url;
  String imageUrl;
  List<PatientHospitalModel> li;
  HospitalModel(this.name,this.city,this.state,this.imageUrl,this.meetLink,this.li);
}
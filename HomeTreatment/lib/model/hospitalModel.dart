import 'package:HomeTreatment/model/patientHospitalModel.dart';
import 'package:HomeTreatment/model/patientModel.dart';

import './patientHospitalModel.dart';
class HospitalModel{
  String _name;
  String _city;
  String _state;
  String _meetLink;
  String _url;
  String _imageUrl;
  List<PatientHospitalModel> _li;
  HospitalModel(this._name,this._city,this._state,this._imageUrl,this._meetLink,this._li);
}
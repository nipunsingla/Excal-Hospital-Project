class PatientModel{
  String _name;
  
  String _email;
    PatientModel(this._name,this._email);

  String getName(){
    return _name;
  }
  String getEmail(){
    return _email;
  }
  void setName(String _name){
      this._name=_name;
  }
  void setEmail(String _email){
    this._email=_email;
  }

}
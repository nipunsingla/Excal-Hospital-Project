class TimeModel{
  String timeSlot;
  bool status;
  TimeModel(this.timeSlot,this.status);
}
class HospitalModel{
  String id;
  String name;
  String city;
  String state;
  String meetLink;
  String url;
  String imageUrl;
  List<dynamic> possibleTimes;
  HospitalModel(this.name,this.city,this.state,this.imageUrl,this.meetLink,this.possibleTimes,this.id);
}
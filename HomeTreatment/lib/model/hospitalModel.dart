class TimeModel{
  String timeSlot;
  String endSlot;
  bool status;
  TimeModel(this.timeSlot,this.status,this.endSlot);
}
class HospitalModel{
  String id;
  String name;
  String city;
  String state;
  String meetLink;
  String url;
  String imageUrl;
  List<TimeModel> possibleTimes;
  HospitalModel(this.name,this.city,this.state,this.imageUrl,this.meetLink,this.possibleTimes,this.id);
}
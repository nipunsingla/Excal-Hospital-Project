import 'package:HomeTreatment/model/AppointmentList.dart';
import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/appointmentList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment-screen';
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<AppointmentList> li = [];
  HospitalModel m;
  void getList() async {
    print(li);
    print("i am " + m.id.toString());
    setState(() {
      li = [];
    });
    print(li);
  }

  bool isInit = false;
  SearchBar searchBar;

  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      m = ModalRoute.of(context).settings.arguments;
      getList();
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: AppointmentListWidget(li, () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => Container(
                    width: 200,
                    child: new AlertDialog(
                      title: FittedBox(
                          child: new Text("Choose Your Appointment",
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor))),
                      content: ListWheelScrollView(
                        itemExtent: 100,
                        renderChildrenOutsideViewport: false,
                        
                        children: <Widget>[
                          ListView.builder(
                            itemCount: m.possibleTimes.length,
                            itemBuilder: (context, index) {
                              print(m.possibleTimes[index]);
                              if (m.possibleTimes[index].status == true) {
                                return AbsorbPointer(
                                  child: Container(
                                    height: 50,
                                    child: RaisedButton(
                                      onPressed: () {},
                                      child: Text(
                                        "${m.possibleTimes[index].timeSlot}-${m.possibleTimes[index].endSlot}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    color: Colors.grey.shade200,
                                  ),
                                );
                              } else {
                                return RaisedButton(
                                  onPressed: () {
                                    
                                  },
                                  child: Text(
                                    "${m.possibleTimes[index].timeSlot}-${m.possibleTimes[index].endSlot}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        RaisedButton.icon(
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            print("tap tap");
                          },
                          icon: Icon(Icons.add, size: 18),
                          label: Text("Online"),
                        ),
                        RaisedButton.icon(
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            print("tap tap");
                          },
                          icon: Icon(Icons.add, size: 18),
                          label: Text("Offline"),
                        ),
                        RaisedButton.icon(
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.add, size: 18),
                          label: Text("Close"),
                        ),
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}

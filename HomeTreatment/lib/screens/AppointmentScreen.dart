import 'package:HomeTreatment/model/AppointmentList.dart';
import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:clipboard/clipboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:provider/provider.dart';

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
      body: Container(
        child: ListView.builder(
          itemCount: m.possibleTimes.length,
          itemBuilder: (context, index) {
            if (m.possibleTimes[index].status == true) {
              return SizedBox(
                width: 0,
              );
            } else {
              print("i am in else");
              return InkWell(
                onTap: () {
                  print("on tap");
                },
                child: RaisedButton(
                  onPressed: () {
                    print("hello");
                    showDialog(
                      context: context,
                      builder: (_) => Container(
                        width: 200,
                        child: new AlertDialog(
                          title: new Text(
                            "Choose Type",
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor),
                          ),
                          actions: <Widget>[
                            RaisedButton.icon(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                bool flag = await Provider.of<Auth>(context,
                                        listen: false)
                                    .makeAppointment(
                                        m.id, m.possibleTimes[index].timeSlot);
                                if (flag) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacementNamed(
                                      MainScreen.routeName);
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Error Try Again')));
                                }
                              },
                              icon: Icon(Icons.add, size: 14),
                              label: Text("Offline"),
                            ),
                            RaisedButton.icon(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Container(
                                    child: AlertDialog(
                                      title: Text(
                                        m.meetLink,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .backgroundColor),
                                      ),
                                      actions: [
                                        RaisedButton.icon(
                                          textColor: Colors.white,
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () async {
                                            bool flag = await Provider.of<Auth>(
                                                    context,
                                                    listen: false)
                                                .makeAppointment(
                                                    m.id,
                                                    m.possibleTimes[index]
                                                        .timeSlot);
                                            if (flag) {
                                              FlutterClipboard.copy(m.meetLink)
                                                  .then((value) {
                                                Navigator.of(context).pop();
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text('Copied')));
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        MainScreen.routeName);
                                              });
                                            } else {
                                              print("error in booking");
                                            }
                                          },
                                          icon: Icon(Icons.add, size: 18),
                                          label: Text("Copy"),
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
                                  ),
                                );
                              },
                              icon: Icon(Icons.add, size: 14),
                              label: Text("Online"),
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
                      ),
                    );
                  },
                  color: Colors.grey.shade200,
                  child: Text(
                    "${m.possibleTimes[index].timeSlot}-${m.possibleTimes[index].endSlot}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

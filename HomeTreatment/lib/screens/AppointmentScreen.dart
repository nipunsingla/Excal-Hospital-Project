import 'package:HomeTreatment/model/AppointmentList.dart';
import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/appointmentList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    List<AppointmentList> temp = await Provider.of<Auth>(context, listen: false)
        .getHospitalAppointmentList(m.id);
    setState(() {
      li = temp;
    });
    print(li);
  }
SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Hospital Treatment'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }
  void initState() {
    super.initState();
    m=ModalRoute.of(context).settings.arguments;
    getList();
  }
  _AppointmentScreenState(){
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: searchBar.build(context),
      key: _scaffoldKey,
      
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
                        children: <Widget>[
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 1",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 6",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 7",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text(
                              "Item 8",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
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

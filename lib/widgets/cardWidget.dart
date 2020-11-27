import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/screens/AppointmentScreen.dart';
import 'package:flutter/material.dart';
import 'package:link/link.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CardWidget extends StatelessWidget {
  final HospitalModel li;
  CardWidget(this.li);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(li.imageUrl), fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: <Widget>[
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.local_hospital_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    label: Text(
                      li.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).backgroundColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          "${li.city}, ${li.state}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey.shade500),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Link(
                        child: Text(
                          'Visit',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline),
                        ),
                        url: li.url,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {},
                          child: RaisedButton.icon(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                print("tap tap");
                                pushNewScreenWithRouteSettings(
                                  context,
                                  screen: AppointmentScreen(),
                                  settings: RouteSettings(
                                      name: AppointmentScreen.routeName,
                                      arguments: li),
                                  withNavBar: false,
                                );
                              },
                              icon: Icon(Icons.add, size: 18),
                              label: Text("Go")),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:link/link.dart';

class CardWidget extends StatelessWidget {
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
                          image: NetworkImage(
                              'https://www.urmc.rochester.edu/MediaLibraries/URMCMedia/strong-memorial/images/Strong-Memorial-Hospital-nighttime.jpg'),
                          fit: BoxFit.cover),
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
                      'AIMS',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).backgroundColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "City, State",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Link(
                        child: Text('Visit',style:TextStyle(
                          color:Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline
                        ),),
                        url: 'https://flutter.dev',
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton.icon(
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            icon: Icon(Icons.add, size: 18),
                            label: Text("Go")),
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

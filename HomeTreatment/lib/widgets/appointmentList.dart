import 'package:HomeTreatment/model/AppointmentList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentListWidget extends StatelessWidget {
  final List<AppointmentList> item;
  final Function _deleteitem;
  AppointmentListWidget(this.item, this._deleteitem);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: item.length==0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('No Appointment',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Container(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      child: Icon(Icons.local_hospital,
                          size: 20, color: Colors.grey.shade400),
                    ))
              ],
            )
          : ListView.builder(
              itemCount: item.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade400,
                      foregroundColor: Colors.white,
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(Icons.local_hospital,
                              size: 40, color: Colors.white),
                        ),
                      ),
                    ),
                    title: Text('Anonymous',style:TextStyle(color:Theme.of(context).backgroundColor)),
                    subtitle: Text(
                        '${DateFormat("hh: mm aa").format(item[index].startTime)}-${DateFormat("hh: mm aa").format(item[index].endTime)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

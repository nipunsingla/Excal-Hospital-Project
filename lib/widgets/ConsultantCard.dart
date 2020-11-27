import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:math';
import 'package:open_mail_app/open_mail_app.dart';

class ConsultantCard extends StatefulWidget {
  final String name;
  final String email;
  final String desc;

  ConsultantCard(this.name, this.email, this.desc);

  @override
  _ConsultantCardState createState() => _ConsultantCardState();
}

class _ConsultantCardState extends State<ConsultantCard> {
  var _expanded = false;

  void toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Email email = Email(
          body: 'code xyz',
          subject:'Have Coupon of assistance from you by HomeTreatment' ,
          recipients: [widget.email],
        );

        String platformResponse;

        try {
          await FlutterEmailSender.send(email);
          platformResponse = 'success';
        } catch (error) {
          platformResponse = error.toString();
        }
      },
      child: Container(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Image.network(
                      'https://www.w3schools.com/w3images/avatar2.png'),
                ),
                title: Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(widget.email),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    toggleExpanded();
                  },
                ),
              ),
            ),
            if (_expanded)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.white,
                ),
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      'Specialization: ${widget.desc}',
                      style: TextStyle(
                        backgroundColor: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

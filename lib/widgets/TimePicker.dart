import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final Function _choosenDate;
  TimePicker(this._choosenDate);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        elevation: 4,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Text("Select a time"),
            ),
            Expanded(
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: _choosenDate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
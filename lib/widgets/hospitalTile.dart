import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/widgets/cardWidget.dart';
import 'package:flippable_box/flippable_box.dart';
import 'package:flutter/material.dart';

class HospitalTile extends StatefulWidget {
  final HospitalModel li;
  HospitalTile(this.li);
  @override
  _HospitalTileState createState() => _HospitalTileState();
}

class _HospitalTileState extends State<HospitalTile>
    with SingleTickerProviderStateMixin {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => setState(
          () => _isFlipped = !_isFlipped,
        ),
        onDoubleTap: () => {print("double tap")},
        child: FlippableBox(
          front:
              Container(width: double.infinity, child: CardWidget(widget.li)),
          back: Container(
            width: double.infinity,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Specification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Specilization in Cardio And Brain",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          flipVt: true,
          isFlipped: _isFlipped,
        ),
      ),
    );
  }
}

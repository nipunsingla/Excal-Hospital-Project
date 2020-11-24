import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget {
  final String _text;
  final Function _moreFun;
  MoreWidget(this._text, this._moreFun);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        child: InkWell(
          onTap: _moreFun,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Text(
                  _text,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.subdirectory_arrow_right, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class InputTextFieldWidget extends StatelessWidget {
  final String _hintText;
  final TextEditingController _controller;
  final IconData _icon;
  
  final TextInputType _t;
  InputTextFieldWidget(this._hintText,this. _controller,this._icon,this._t);
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(
        validator: (value){
          if(_hintText=="email" && !EmailValidator.validate(value)){
            return "unvalid email";
          }
          if(value.isEmpty){
            return "please fill value";
          }
          return null;
        },
        keyboardType: _t,
        controller: _controller,
        decoration: InputDecoration(
            prefixIcon: Icon(
              _icon,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide(color: Colors.white24)
                //borderSide: const BorderSide(),
                ),
            hintStyle:
                TextStyle(color: Colors.white, fontFamily: "WorkSansLight"),
            filled: true,
            fillColor: Colors.white24,
            hintText: _hintText),
      ),
    );
  }
}

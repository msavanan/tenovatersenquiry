import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  UserTextField({this.onSaved, this.validator, this.hintTxt, this.labelTxt});
  late final FormFieldSetter<String>? onSaved;
  late final FormFieldValidator<String>? validator;
  final String? hintTxt;
  final String? labelTxt;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      autocorrect: false,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusColor: Colors.black,
        hoverColor: Colors.black,
        labelText: labelTxt,
        labelStyle: TextStyle(color: Colors.black),
        hintText: hintTxt,
        filled: true,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
    );
  }
}
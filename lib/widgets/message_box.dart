import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  String _message;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (message) => _message = message,
      validator: (message) => message.isEmpty ? '*Required' : null,
      autocorrect: false,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      minLines: 5,
      maxLines: null,
      decoration: InputDecoration(
        labelText: 'Message',
        alignLabelWithHint: true,
        hintText: 'Your message',
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        border: OutlineInputBorder(),
      ),
    );
  }
}

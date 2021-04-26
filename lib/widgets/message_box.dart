import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/user_text_form_field.dart';

class MessageBox extends StatefulWidget {
  final messageController;
  final subjectController;
  MessageBox({this.messageController, this.subjectController});

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserTextField(
          controller: widget.subjectController,
          hintTxt: 'subject',
          labelTxt: 'Subject*',
          validator: (subject) => subject.isEmpty ? '*Required' : null,
        ),
        Container(
          height: 20,
        ),
        TextFormField(
          controller: widget.messageController,
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
        )
      ],
    );
  }
}

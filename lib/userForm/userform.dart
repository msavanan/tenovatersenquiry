import 'package:tenovatersenquiry/constants.dart';
import 'package:tenovatersenquiry/userForm/user_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/validator.dart';

import 'user_text_form_field.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

//Todo number validator currently accepts 10 or 12 numbers
class _UserFormState extends State<UserForm> {
  String? _email;
  String? _firstName;
  String? _message;

  bool? _signup;

  final _userFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //double aspectRatio = width / height;
    double spacer = height / 40; //(aspectRatio * 100);

    return Form(
      key: _userFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        margin: EdgeInsets.only(
            left: width * 0.05, right: width * 0.05, top: height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spacer),
            UserTextField(
              hintTxt: 'Name',
              labelTxt: 'Name*',
              validator:
                  nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
              onSaved: (firstName) => _firstName = firstName,
            ),
            SizedBox(height: spacer),
            UserTextField(
              hintTxt: 'E-mail',
              labelTxt: 'E-mail*',
              validator: emailValidator,
              onSaved: (email) => _email = email,
            ),
            SizedBox(height: spacer),
            TextFormField(
              onSaved: (message) => _message = message,
              validator: (message) => message!.isEmpty ? '*Required' : null,
              autocorrect: false,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Message',
                alignLabelWithHint: true,
                hintText: 'Your message',
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: spacer),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Checkbox(
                  value: _signup ?? false,
                  onChanged: (value) {
                    setState(() {
                      _signup = value;
                    });
                  },
                ),
                Container(
                  width: width * 0.75,
                  child: Text(
                    'Sign up to receive email updates, announcements, and more.',
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacer),
            Center(
              child: MaterialButton(
                //minWidth: double.infinity, //width * 0.8,
                onPressed: () {
                  if (_userFormKey.currentState!.validate()) {
                    _userFormKey.currentState!.save();
                    print('First Name: $_firstName');
                    print('E-mail ID: $_email');
                  }
                },
                child: Text(
                  "SEND",
                  style: TextStyle(fontSize: height * 0.03),
                ),
                color: primaryColor,
                padding: EdgeInsets.all(height * 0.02),
              ),
            )
          ],
        ),
      ),
    );
  }
}

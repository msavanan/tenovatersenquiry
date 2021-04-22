import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/pages/guest_page.dart';
import 'package:tenovatersenquiry/pages/sign_in.dart';
import 'package:tenovatersenquiry/userForm/user_text_form_field.dart';
import 'package:tenovatersenquiry/userForm/userform.dart';
import 'package:tenovatersenquiry/userForm/validator.dart';
import 'package:tenovatersenquiry/widgets/headerWidget.dart';

import 'query_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double spacer = height / 40;

    String _email;
    String _password;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(width, height * 0.2), child: HeaderWidget()),
        body: Container(
          height: height * 0.7,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                      top: height * 0.05),
                  child: Column(children: [
                    UserTextField(
                      hintTxt: 'E-mail',
                      labelTxt: 'E-mail*',
                      validator: emailValidator,
                      onSaved: (email) => _email = email,
                    ),
                    Container(height: spacer),
                    UserTextField(
                      hintTxt: 'Passsword',
                      labelTxt: 'Passsword*',
                      validator: passwordValidator,
                      obscureTxt: true,
                      onSaved: (password) => _password = password,
                    ),
                    Container(height: spacer),
                  ]),
                ),
                Container(height: spacer),
                ElevatedButton(
                    onPressed: () {
                      print('Clicked');
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return QueryPage();
                      }));
                    },
                    child: Container(
                        height: 50,
                        width: width * 0.5,
                        child: Center(
                          child: Text(
                            'Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        ))),
                Container(height: spacer),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SignIn();
                      }));
                    },
                    child: Container(
                        height: 50,
                        width: width * 0.5,
                        child: Center(
                          child: Text(
                            'Create User Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        ))),
                Container(height: spacer),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return GuestPage();
                          /*Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return GuestPage();*/
                        },
                      ));
                    },
                    child: Container(
                        height: 50,
                        width: width * 0.5,
                        child: Center(
                          child: Text(
                            'Guest',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        ))),
                Container(height: spacer),
                GestureDetector(
                    onTap: () {},
                    child:
                        Container(height: 50, child: Text('Forgot PassWord'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

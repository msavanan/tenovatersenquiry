import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/user_text_form_field.dart';
import 'package:tenovatersenquiry/userForm/validator.dart';
import 'package:tenovatersenquiry/widgets/headerWidget.dart';

import '../constants.dart';
import 'homePage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _userFormKey = GlobalKey<FormState>();
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _conformationCode;

  bool _isSignedUp = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacer = height / 40;

    void _signUp() async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Signing Up...")));
      Map<String, String> userAttributes = {"email": _email};
      try {
        await Amplify.Auth.signUp(
            username: _email.trim(),
            password: _password.trim(),
            options: CognitoSignUpOptions(userAttributes: userAttributes));
        setState(() {
          _isSignedUp = true;
        });
      } on AuthException catch (error) {
        setState(() {
          _isSignedUp = false;
        });
        print(error.message);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Sign up failed, do you already have an account?")));
      } on Exception catch (error) {
        print(error);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("An unknown error occurred")));
      }
    }

    void _confirm() async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Confirming...')));
      try {
        await Amplify.Auth.confirmSignUp(
            username: _email.trim(),
            confirmationCode: _conformationCode.trim());
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Confirmed, you can now login.')));
        setState(() {
          _isSignedUp = false;
        });
      } on AuthException catch (error) {
        print(error.message);
        setState(() {
          _isSignedUp = false;
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(width, height * 0.2), child: HeaderWidget()),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(
                  left: width * 0.05, right: width * 0.05, top: height * 0.05),
              child: Container(
                child: Column(children: [
                  Visibility(
                    visible: _isSignedUp,
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UserTextField(
                              hintTxt: 'OTP*',
                              labelTxt: 'OTP',
                              validator: (value) {
                                return 'Check your E-mail for OTP';
                              },
                              onSaved: (otp) => _conformationCode = otp,
                            ),
                            Container(height: height * 0.1),
                            Center(
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    _confirm();
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return HomePage();
                                  }));
                                },
                                child: Text(
                                  "Confirm OTP",
                                  style: TextStyle(fontSize: height * 0.04),
                                ),
                                color: primaryColor,
                                padding: EdgeInsets.all(height * 0.02),
                              ),
                            ),
                            Container(height: spacer),
                          ]),
                    ),
                  ),
                  Visibility(
                    visible: !_isSignedUp,
                    child: Form(
                      key: _userFormKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: spacer),
                            UserTextField(
                              hintTxt: 'First Name',
                              labelTxt: 'First Name*',
                              validator:
                                  nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                              onSaved: (firstName) => _firstName = firstName,
                            ),
                            Container(height: spacer),
                            UserTextField(
                              hintTxt: 'Last Name',
                              labelTxt: 'Last Name*',
                              validator:
                                  nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                              onSaved: (lastName) => _lastName = lastName,
                            ),
                            Container(height: spacer),
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
                            Center(
                              child: Container(
                                  height: 50,
                                  width: width * 0.6,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (_userFormKey.currentState
                                            .validate()) {
                                          _userFormKey.currentState.save();
                                          _signUp();
                                        }
                                        setState(() {
                                          _isSignedUp = true;
                                        });
                                        /* Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext context) {
                                          return ConfirmOTP();
                                        })); */
                                      },
                                      child: Text(
                                        'SignUp',
                                        style: TextStyle(),
                                      ))),
                            ),
                          ]),
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}

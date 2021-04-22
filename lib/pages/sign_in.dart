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

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conformationCode = TextEditingController();

  bool _isSignedUp = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacer = height / 40;

    void _signUp() async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Signing Up...")));
      Map<String, String> userAttributes = {"email": _email.text};
      try {
        await Amplify.Auth.signUp(
            username: _email.text.trim(),
            password: _password.text.trim(),
            options: CognitoSignUpOptions(userAttributes: userAttributes));
        setState(() {
          _isSignedUp = true;
        });
      } on AuthException catch (error) {
        setState(() {
          _isSignedUp = false;
        });
        print(error.message);
        setState(() {
          _isSignedUp = true;
        });
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
            username: _email.text.trim(),
            confirmationCode: _conformationCode.text.trim());
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
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(children: [
                    Visibility(
                      visible: _isSignedUp,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UserTextField(
                              textEditingController: _conformationCode,
                              hintTxt: 'OTP*',
                              labelTxt: 'OTP',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Check your E-mail for OTP';
                                }
                                return null;
                              },
                            ),
                            Container(height: height * 0.1),
                            Center(
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
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
                    Visibility(
                      visible: !_isSignedUp,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: spacer),
                            UserTextField(
                              textEditingController: _firstName,
                              hintTxt: 'First Name',
                              labelTxt: 'First Name*',
                              validator:
                                  nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                            ),
                            Container(height: spacer),
                            UserTextField(
                              textEditingController: _lastName,
                              hintTxt: 'Last Name',
                              labelTxt: 'Last Name*',
                              validator:
                                  nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                            ),
                            Container(height: spacer),
                            UserTextField(
                              textEditingController: _email,
                              hintTxt: 'E-mail',
                              labelTxt: 'E-mail*',
                              validator: emailValidator,
                            ),
                            Container(height: spacer),
                            UserTextField(
                              textEditingController: _password,
                              hintTxt: 'Passsword',
                              labelTxt: 'Passsword*',
                              validator: passwordValidator,
                              obscureTxt: true,
                            ),
                            Container(height: spacer),
                            Center(
                              child: Container(
                                  height: 50,
                                  width: width * 0.6,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          //_userFormKey.currentState.save();
                                          _signUp();
                                        }
                                        /*setState(() {
                                          _isSignedUp = true;
                                        });*/
                                      },
                                      child: Text(
                                        'SignUp',
                                        style: TextStyle(),
                                      ))),
                            ),
                          ]),
                    ),
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}

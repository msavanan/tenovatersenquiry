import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/user_text_form_field.dart';
import 'package:tenovatersenquiry/userForm/validator.dart';
import 'package:tenovatersenquiry/widgets/headerWidget.dart';

import '../constants.dart';
import 'homePage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformationCodeController =
      TextEditingController();

  bool _isSignedUp = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacer = height / 40;

    void _signUp() async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Signing Up...")));
      Map<String, String> userAttributes = {"email": _emailController.text};
      try {
        await Amplify.Auth.signUp(
            username: _emailController.text.trim(),
            password: _passwordController.text.trim(),
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
            username: _emailController.text.trim(),
            confirmationCode: _conformationCodeController.text.trim());
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
                              Controller: _conformationCodeController,
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return HomePage();
                                    }));
                                  }
                                },
                                child: Text(
                                  "Confirm OTP",
                                  style: TextStyle(fontSize: height * 0.025),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(height: spacer),
                            UserTextField(
                              Controller: _firstNameController,
                              hintTxt: 'First Name',
                              labelTxt: 'First Name*',
                              validator:
                                  nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                            ),
                            Container(height: spacer),
                            UserTextField(
                              Controller: _lastNameController,
                              hintTxt: 'Last Name',
                              labelTxt: 'Last Name*',
                              validator:
                                  nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                            ),
                            Container(height: spacer),
                            UserTextField(
                              Controller: _emailController,
                              hintTxt: 'E-mail',
                              labelTxt: 'E-mail*',
                              validator: emailValidator,
                            ),
                            Container(height: spacer),
                            UserTextField(
                              Controller: _passwordController,
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
                                      },
                                      child: Text(
                                        'SignUp',
                                        style: TextStyle(),
                                      ))),
                            ),
                            Container(height: spacer),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSignedUp = true;
                                  });
                                },
                                child: Text('Confirmation Code')),
                            Container(height: spacer),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  }));
                                },
                                child: Center(child: Text('SignIn'))),
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

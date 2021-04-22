import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:tenovatersenquiry/constants.dart';
import 'package:tenovatersenquiry/pages/homePage.dart';
import 'package:tenovatersenquiry/userForm/user_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/validator.dart';
import 'package:tenovatersenquiry/widgets/headerWidget.dart';
import 'package:tenovatersenquiry/widgets/message_box.dart';

import 'user_text_form_field.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

//Todo number validator currently accepts 10 or 12 numbers
class _UserFormState extends State<UserForm> {
  String _email;
  String _name;
  String _message;

  bool _signup;

  String _otp;

  final _userFormKey = GlobalKey<FormState>();

  bool isSignUpComplete;

  bool _isSignedUp;

  void _confirm(
      BuildContext context, String email, String confirmationCode) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Confirming...')));
    try {
      await Amplify.Auth.confirmSignUp(
          username: email.trim(), confirmationCode: confirmationCode.trim());
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacer = height / 40;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(width, height * 0.2), child: HeaderWidget()),
        body: Form(
          key: _userFormKey,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
            margin: EdgeInsets.only(
                left: width * 0.05, right: width * 0.05, top: height * 0.05),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: spacer),
                UserTextField(
                  hintTxt: 'Name',
                  labelTxt: 'Name*',
                  validator:
                      nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                  onSaved: (name) => _name = name,
                ),
                Container(height: spacer),
                UserTextField(
                  hintTxt: 'E-mail',
                  labelTxt: 'E-mail*',
                  validator: emailValidator,
                  onSaved: (email) => _email = email,
                ),
                Container(height: spacer),
                MessageBox(),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Checkbox(
                      value: _signup ?? false,
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
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
                ),*/

                Container(height: spacer),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HomePage();
                      }));

                      /*   if (_otpKey.currentState.validate()) {
                                      _userFormKey.currentState.save();
                                      print('First Name: $_name');
                                      print('E-mail ID: $_email');
                                    }

                                    if (_email != null) {
                                      try {
                                        Map<String, String> userAttributes = {
                                          'email': _email,
                                        };

                                        SignUpResult res =
                                            await Amplify.Auth.signUp(
                                                username: _email.trim(),
                                                password: 'Welcome@123',
                                                options: CognitoSignUpOptions(
                                                    userAttributes:
                                                        userAttributes));
                                        setState(() {
                                          isSignUpComplete = res.isSignUpComplete;
                                        });
                                      } on AuthException catch (e) {
                                        print(e.message);

                                        if (e.message.contains(
                                            'Username already exists in the system.')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Username already exists")));
                                          await Amplify.Auth.signOut();
                                          return 'Problem logging in. Please try again.';
                                        }

                                        return '${e.message} - ${e.recoverySuggestion}';
                                      }

                                      _confirm(context, _email, _otp);
                                    }*/
                    },
                    child: Text(
                      "SEND",
                      style: TextStyle(fontSize: height * 0.03),
                    ),
                    color: primaryColor,
                    padding: EdgeInsets.all(height * 0.02),
                  ),
                ),
                Container(height: spacer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

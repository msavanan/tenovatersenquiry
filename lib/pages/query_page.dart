import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/pages/homePage.dart';
import 'package:tenovatersenquiry/widgets/headerWidget.dart';
import 'package:tenovatersenquiry/widgets/message_box.dart';

import '../amplify_data.dart';
import '../constants.dart';

class QueryPage extends StatefulWidget {
  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  // ignore: missing_return
  /* Future<List<dynamic>> getQuery() async {
    try {
      return await Amplify.DataStore.query(Enquiry.classType);
    } catch (e) {
      print('Query failed: $e');
    }
  }*/

  //List<Enquiry> enquiryList = [];

  final _messageFormKey = GlobalKey<FormState>();

  TextEditingController _messageController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();

  bool visibleStatus = false;

  // ignore: missing_return
  Future<String> getUserID() async {
    try {
      final authUser = await Amplify.Auth.fetchUserAttributes();
      return authUser[2].value;
    } catch (e) {
      print(e);
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
          body: Container(
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  children: [
                    Container(height: spacer),
                    /*Container(
                        height: MediaQuery.of(context).size.height * .3,
                        child: QueryListView(
                          getQuery: getQuery,
                        )),*/
                    Container(height: spacer),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Column(children: [
                        Form(
                            key: _messageFormKey,
                            child: MessageBox(
                              messageController: _messageController,
                              subjectController: _subjectController,
                            )),
                        Visibility(
                            visible: visibleStatus,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                      ]),
                    ),
                    Container(height: spacer),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (currentFocus.hasFocus) {
                            currentFocus.unfocus();
                          }
                          if (_messageFormKey.currentState.validate()) {
                            setState(() {
                              visibleStatus = true;
                            });

                            try {
                              final email = await getUserID();
                              final String subject =
                                  _subjectController.text.trim();
                              final String message =
                                  _messageController.text.trim();
                              await save(
                                  date: TemporalDateTime(DateTime.now()),
                                  email: email,
                                  subject: subject,
                                  message: message);

                              _subjectController.text = '';
                              _messageController.text = '';
                            } catch (e) {
                              print("Save Failed to save : $e");
                            }

                            setState(() {
                              visibleStatus = false;
                            });
                          }
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
                    Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (currentFocus.hasFocus) {
                            currentFocus.unfocus();
                          }
                          try {
                            await Amplify.Auth.signOut();
                          } on AuthException catch (e) {
                            print(e.message);
                          }

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        child: Text('Sign Out'),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          )),
    );
  }
}

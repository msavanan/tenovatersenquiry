import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/models/Enquiry.dart';
import 'package:tenovatersenquiry/pages/homePage.dart';
import 'package:tenovatersenquiry/query_list_view.dart';
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
  Future<List<dynamic>> getQuery() async {
    try {
      return await Amplify.DataStore.query(Enquiry.classType);
    } catch (e) {
      print('Query failed: $e');
    }
  }

  List<Enquiry> enquiryList = [];

  bool enquiryState = false;

  final _messageFormKey = GlobalKey<FormState>();

  TextEditingController _messageController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();

  bool visibleStatus = false;

  Future<String> getUserID() async {
    try {
      final authUser = await Amplify.Auth.fetchUserAttributes();
      return authUser[2].value;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    //getQuery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacer = height / 40;

    _messageController.text = '';
    print(enquiryList);

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
                    Container(
                        height: MediaQuery.of(context).size.height * .3,
                        child: QueryListView(
                          getQuery: getQuery,
                        )),
                    Container(height: spacer),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      //height: MediaQuery.of(context).size.height * .25,
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
                          await Amplify.DataStore.clear();
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (currentFocus.hasFocus) {
                            currentFocus.unfocus();
                          }
                          print(_subjectController.text.trim());
                          print(_messageController.text.trim());
                          if (_messageFormKey.currentState.validate()) {
                            setState(() {
                              visibleStatus = true;
                            });
                            final email = await getUserID();
                            print('email: $email');
                            await save(
                                date: TemporalDateTime(DateTime.now()),
                                email: email,
                                subject: _subjectController.text.trim(),
                                message: _messageController.text.trim());
                            setState(() {
                              visibleStatus = false;
                            });
                            _messageController.text = '';
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

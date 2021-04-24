import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/models/Enquiry.dart';
import 'package:tenovatersenquiry/pages/homePage.dart';

class QueryPage extends StatelessWidget {
  Future<List> getQuery() async {
    List<Enquiry> enquiryList =
        await Amplify.DataStore.query(Enquiry.classType);
    return enquiryList;
  }

  final List<Enquiry> enquiryList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          child: Container(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await Amplify.Auth.signOut();
            } on AuthException catch (e) {
              print(e.message);
            }

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          },
          child: Text('Sign Out'),
        ),
      )),
    );
  }
}

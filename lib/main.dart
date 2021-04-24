import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/constants.dart';
import 'package:tenovatersenquiry/pages/homePage.dart';
import 'package:tenovatersenquiry/pages/query_page.dart';
import 'package:tenovatersenquiry/pages/sign_up.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(Enquiry());
}

class Enquiry extends StatefulWidget {
  @override
  _EnquiryState createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  AmplifyAuthCognito auth = AmplifyAuthCognito();
  AmplifyStorageS3 storage = AmplifyStorageS3();

  bool configured = false;
  bool authenticated = false;

  @override
  initState() {
    super.initState();
    Amplify.addPlugins([auth, storage]);

    Amplify.configure(amplifyconfig).then((value) {
      print("Amplify Configured");
      setState(() {
        configured = true;
      });
    }).catchError(print);
  }

  Future<void> _checkSession() async {
    print("Checking Auth Session...");
    try {
      var session = await auth.fetchAuthSession();
      authenticated = session.isSignedIn;
      print('------------------------------');
      print(authenticated);
    } catch (error) {
      print(error);
    }
    _setupAuthEvents();
  }

  void _setupAuthEvents() {
    Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case "SIGNED_IN":
          {
            print("HUB: USER IS SIGNED IN");
            setState(() {
              authenticated = true;
            });
          }
          break;
        case "SIGNED_OUT":
          {
            print("HUB: USER IS SIGNED OUT");
            setState(() {
              authenticated = false;
            });
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("HUB: USER SESSION EXPIRED");
            setState(() {
              authenticated = false;
            });
          }
          break;
        default:
          {
            print("HUB: CONFIGURATION EVENT");
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(229, 173, 16, .1),
      100: Color.fromRGBO(229, 173, 16, .2),
      200: Color.fromRGBO(229, 173, 16, .3),
      300: Color.fromRGBO(229, 173, 16, .4),
      400: Color.fromRGBO(229, 173, 16, .5),
      500: Color.fromRGBO(229, 173, 16, .6),
      600: Color.fromRGBO(229, 173, 16, .7),
      700: Color.fromRGBO(229, 173, 16, .8),
      800: Color.fromRGBO(229, 173, 16, .9),
      900: Color.fromRGBO(229, 173, 16, 1),
    };
    Color myColor = MaterialColor(0xFFFe5ad10, color);

    return MaterialApp(
        theme: ThemeData(
          primaryColor: myColor,
          primarySwatch: myColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Montserrat",
          iconTheme: IconThemeData(color: Colors.black),
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor, //Colors.amber,
            disabledColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        home: FutureBuilder<void>(
          future: _checkSession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return authenticated ? QueryPage() : HomePage(); //SignUp();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

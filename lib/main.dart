import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/constants.dart';
import 'package:tenovatersenquiry/userForm/userform.dart';

void main() {
  runApp(Enquiry());
}

class Enquiry extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: Container(
            /*decoration:
                BoxDecoration(color: Colors.white, border: Border.all()), */
            /*padding: EdgeInsets.all(1),*/
            child: EnquiryLayout()));
  }
}

class EnquiryLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        Expanded(
          flex: 1,
          child: LayoutBuilder(builder: (BuildContext context, constraints) {
            print(constraints.maxHeight);
            return ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: constraints.maxHeight * 0.15),
              child: Container(
                  padding: EdgeInsets.only(
                      left: width * 0.05, top: constraints.maxHeight * 0.3),
                  decoration: BoxDecoration(
                    color: primaryColor, /*border: Border.all()*/
                  ),
                  width: width,
                  child: Text(
                    'Tenevators Group',
                    style: TextStyle(fontSize: width * 0.075),
                  )),
            );
          }),
        ),
        Expanded(
          flex: 4,
          child: SingleChildScrollView(child: UserForm()),
        ),
      ])),
    );
  }
}

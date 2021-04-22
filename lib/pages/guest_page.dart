import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/userform.dart';
import 'package:tenovatersenquiry/widgets/headerWidget.dart';

class GuestPage extends StatefulWidget {
  @override
  _GuestPageState createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          //Container(height: height * 0.2, child: HeaderWidget()),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(height: height, child: UserForm())))
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/userform.dart';

class GuestPage extends StatefulWidget {
  @override
  _GuestPageState createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Container(height: height, child: UserForm())))
        ],
      ),
    );
  }
}

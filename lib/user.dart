import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String firstName;
  String lastName;
  String email;
  String password;

  User({this.firstName, this.lastName, this.email, this.password});
}

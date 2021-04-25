import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:tenovatersenquiry/constants.dart';
import 'package:tenovatersenquiry/models/Enquiry.dart';
import 'package:tenovatersenquiry/models/ModelProvider.dart';
import 'package:tenovatersenquiry/pages/homePage.dart';
import 'package:tenovatersenquiry/userForm/user_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:tenovatersenquiry/userForm/validator.dart';
import 'package:tenovatersenquiry/widgets/headerWidget.dart';
import 'package:tenovatersenquiry/widgets/message_box.dart';

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
// Add the following line

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

//Todo number validator currently accepts 10 or 12 numbers
class _UserFormState extends State<UserForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final _userFormKey = GlobalKey<FormState>();

  save({TemporalDateTime date, String email, String message}) async {
    /*StreamSubscription hubSubscription =
        Amplify.Hub.listen([HubChannel.Auth], (hubEvent) async {
      if (hubEvent.eventName == 'SIGNED_OUT') {
        try {
          await Amplify.DataStore.clear();
          print('DataStore is cleared.');
        } on DataStoreException catch (e) {
          print('Failed to clear DataStore: $e');
        }
      }
    });*/

    Enquiry enquiry = Enquiry(date: date, email: email, message: message);
    await Amplify.DataStore.save(enquiry);
    List<Enquiry> enquiryList = await Amplify.DataStore.query(
      Enquiry.classType,
    );
    print('---------');
    print(enquiryList);
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
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  left: width * 0.05, right: width * 0.05, top: height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: spacer),
                  UserTextField(
                    Controller: _nameController,
                    hintTxt: 'Name',
                    labelTxt: 'Name*',
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
                  MessageBox(
                    messageController: _messageController,
                  ),
                  Container(height: spacer),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        if (_userFormKey.currentState.validate()) {
                          /*print(_nameController.text.trim());
                          print(_emailController.text.trim());
                          print(_messageController.text);*/
                          /*Enquiry enquiry = Enquiry(
                              date: TemporalDateTime(DateTime.now()),
                              email: _emailController.text.trim(),
                              message: _messageController.text.trim());
                          await Amplify.DataStore.save(enquiry);*/
                          await save(
                              date: TemporalDateTime(DateTime.now()),
                              email: _emailController.text.trim(),
                              message: _messageController.text.trim());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return HomePage();
                          }));
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

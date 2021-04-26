import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';

import 'models/Enquiry.dart';

save(
    {TemporalDateTime date,
    String email,
    String subject,
    String message}) async {
  Enquiry enquiry =
      Enquiry(date: date, email: email, subject: subject, message: message);
  await Amplify.DataStore.save(enquiry);
  //List<Enquiry> enquiryList = await Amplify.DataStore.query(Enquiry.classType,);
}

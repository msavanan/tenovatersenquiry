/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Enquiry type in your schema. */
@immutable
class Enquiry extends Model {
  static const classType = const _EnquiryModelType();
  final String id;
  final TemporalDateTime date;
  final String email;
  final String message;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Enquiry._internal(
      {@required this.id,
      @required this.date,
      @required this.email,
      @required this.message});

  factory Enquiry(
      {String id,
      @required TemporalDateTime date,
      @required String email,
      @required String message}) {
    return Enquiry._internal(
        id: id == null ? UUID.getUUID() : id,
        date: date,
        email: email,
        message: message);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Enquiry &&
        id == other.id &&
        date == other.date &&
        email == other.email &&
        message == other.message;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Enquiry {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("date=" + (date != null ? date.format() : "null") + ", ");
    buffer.write("email=" + "$email" + ", ");
    buffer.write("message=" + "$message");
    buffer.write("}");

    return buffer.toString();
  }

  Enquiry copyWith(
      {String id, TemporalDateTime date, String email, String message}) {
    return Enquiry(
        id: id ?? this.id,
        date: date ?? this.date,
        email: email ?? this.email,
        message: message ?? this.message);
  }

  Enquiry.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'] != null
            ? TemporalDateTime.fromString(json['date'])
            : null,
        email = json['email'],
        message = json['message'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'date': date?.format(), 'email': email, 'message': message};

  static final QueryField ID = QueryField(fieldName: "enquiry.id");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField MESSAGE = QueryField(fieldName: "message");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Enquiry";
    modelSchemaDefinition.pluralName = "Enquiries";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Enquiry.DATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Enquiry.EMAIL,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Enquiry.MESSAGE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _EnquiryModelType extends ModelType<Enquiry> {
  const _EnquiryModelType();

  @override
  Enquiry fromJson(Map<String, dynamic> jsonData) {
    return Enquiry.fromJson(jsonData);
  }
}
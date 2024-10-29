// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum UniversityStatus { student, professor, staff}
enum Pronouns { she, he, they }

extension PronounsExtension on Pronouns {
  String get pronounLabel {
    switch (this) {
      case Pronouns.she:
        return 'she/her';
      case Pronouns.he:
        return 'he/him';
      default:
        return 'they/them';
    }
  }
}

class User {
  String firstName;
  String lastName;
  String email;
  UniversityStatus universityStatus;
  Map<Pronouns, bool> pronouns; 

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.universityStatus,
    Map<Pronouns, bool>? pronouns,
    }): pronouns = {for (var p in Pronouns.values)
            p: false};
  

  static User empty(){
    return User(
      firstName: '',
      lastName: '',
      email: '',
      universityStatus: UniversityStatus.student,
    );
  }

  setFirstName(String firstName){
    this.firstName = firstName;
  }

  setLastName(String lastName){
    this.lastName = lastName;
  }  

  setStatus(UniversityStatus status){
    universityStatus = status;
  }

  User duplicate({
    String? firstName,
    String? lastName,
    String? email,
    UniversityStatus? universityStatus,
    Map<Pronouns, bool>? pronouns,
  }) {
    Map<Pronouns, bool> pronouns2 = pronouns != null ? Map.from(pronouns) : Map.from(this.pronouns);

    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      universityStatus: universityStatus  ?? this.universityStatus,
      pronouns: pronouns ?? pronouns2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'universityStatus': universityStatus.toString(),
      'pronouns': pronouns.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      universityStatus: map['universityStatus'],
      pronouns: map['pronouns'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, university status: $universityStatus, \n pronouns: $pronouns)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.universityStatus == universityStatus &&
      mapEquals(other.pronouns, pronouns);
  }

}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum UniversityStatus { student, professor, staff}

class User {
  String firstName;
  String lastName;
  String email;
  UniversityStatus universityStatus;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.universityStatus,
  });

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
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      universityStatus: universityStatus  ?? this.universityStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'universityStatus': universityStatus.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      universityStatus: map['universityStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, university status: $universityStatus)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.universityStatus == universityStatus;
  }

}

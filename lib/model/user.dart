// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum UniversityStatus { student, professor, staff}

class User {
  String firstName;
  String lastName;
  String email;
  UniversityStatus universityStatus;
  String major;
  double gpa;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.universityStatus,
    required this.major,
    required this.gpa,
  });

  static User empty(){
    return User(
      firstName: '',
      lastName: '',
      email: '',
      universityStatus: UniversityStatus.student,
      major: '',
      gpa: 4.0,
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

  setMajor(String major){
    this.major = major;
  }

  setGPA(double gpa){
    this.gpa = gpa;
  }


  User duplicate({
    String? firstName,
    String? lastName,
    String? email,
    UniversityStatus? universityStatus,
    String? major,
    double? gpa,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      universityStatus: universityStatus  ?? this.universityStatus,
      major: major ?? this.major,
      gpa: gpa ?? this.gpa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'universityStatus': universityStatus.toString(),
      'major': major,
      'gpa': gpa,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      universityStatus: map['universityStatus'],
      major: map['major'],
      gpa: map['gpa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, university status: $universityStatus, major: $major, gpa: $gpa)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.universityStatus == universityStatus &&
      other.major == major &&
      other.gpa == gpa;
  }

}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String firstName;
  String lastName;
  String email;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  static User empty(){
    return User(
      firstName: '',
      lastName: '',
      email: '',
    );
  }

  setFirstName(String firstName){
    this.firstName = firstName;
  }

  User duplicate({
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email;
  }

}

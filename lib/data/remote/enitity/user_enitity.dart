import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  String userId;
  String userName;
  String contact;
  String email;
  String dob;
  String gender;
  String role;

  UserEntity({
   this.userId = '',
    required this.userName,
    required this.contact,
    this.email ='',
    this.dob = '',
    this.gender = '',
    this.role = 'user'
  });

  Map<String, dynamic> toJson() => {
    'id': userId,
    'name': userName,
    'contact': contact,
    'email': email,
    'dob': dob,
    'gender': gender,
    'role':role
  };

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['id'],
      userName: json['name'],
      contact: json['contact'],
      email: json['email'],
      dob: json['dob'],
      gender: json['gender'],
      role: json['role']
    );
  }

  factory UserEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserEntity(
        userId: data?['id'],
        userName: data?['name'],
        contact: data?['contact'],
        email: data?['email'],
        dob: data?['dob'],
        gender: data?['gender'],
        role: data?['role']
    );
  }
}
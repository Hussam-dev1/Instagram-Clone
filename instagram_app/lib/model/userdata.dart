import 'package:cloud_firestore/cloud_firestore.dart';

class UserDate {
  String password;
  String email;
  String age;
  String username;
  String prfileimg;
  String uid;
  List following;
  List follwers;
  UserDate(
      {required this.email,
      required this.password,
      required this.age,
      required this.username,
      required this.prfileimg,
      required this.uid,
      required this.follwers,
      required this.following});

  Map<String, dynamic> convert2Map() {
    return {
      "password": password,
      "email": email,
      "age": age,
      "username": username,
      "profileimg": prfileimg,
      "uid": uid,
      "follwers": [],
      "following": [],
    };
  }

  
}

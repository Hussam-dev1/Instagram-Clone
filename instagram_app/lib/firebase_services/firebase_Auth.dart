import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Sherd/snackbar.dart';
import 'package:instagram_app/firebase_services/firebase_storg.dart';
import 'package:instagram_app/model/userdata.dart';

class AuthMethod {
  rigster(
      {required eemail,
      required password,
      required context,
      required username,
      required age,
      required imgPath,
      required imgName}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: eemail, password: password);

      String urlll = await getImgURL(
          imgName: imgName, imgPath: imgPath, foldername: 'aaa');

      CollectionReference users = FirebaseFirestore.instance.collection('User');
      UserDate userdata = UserDate(
          username: username,
          age: age,
          email: eemail,
          password: password,
          prfileimg: urlll,
          uid: credential.user!.uid,
          follwers: [],
          following: []);
      users
          .doc(credential.user!.uid)
          .set(
            userdata.convert2Map(),
            SetOptions(merge: true),
          )
          .then((value) =>
              print("'full_name' & 'age' merged with existing data!"))
          .catchError((error) => print("Failed to merge data: $error"));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, " ${e.code}");
    } catch (e) {
      print(e);
    }
  }

  Sginin({required email, required pasword, required context}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pasword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "user not found");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "wrong password");
      }
    }
  }

  // functoin to get user details from Firestore (Database)
 
}

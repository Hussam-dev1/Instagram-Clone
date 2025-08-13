import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/Sherd/snackbar.dart';
import 'package:instagram_app/firebase_services/firebase_storg.dart';
import 'package:instagram_app/model/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  uplodpost(
      {required profileImg,
      required description,
      required context,
      required username,
      required imgPath,
      required imgName}) async {
    try {
      String urlll = await getImgURL(imgName: imgName, imgPath: imgPath, foldername: 'aaa');

      CollectionReference post =
          FirebaseFirestore.instance.collection('Posts');
      PostData Posts = PostData(
          profileImg: profileImg,
          username: username,
          description: description,
          imgPost: urlll,
          uid: FirebaseAuth.instance.currentUser!.uid,
          postId: Uuid().v1(),
          datePublished: DateTime.now(),
          likes: []);

      post
          .doc(Uuid().v1(),)
          .set(
            Posts.convert2Map(),
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
}

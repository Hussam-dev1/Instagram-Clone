import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

getImgURL({
 required String imgName,
 required Uint8List imgPath,
  required String foldername,
 }) async {
 
   final storageRef = FirebaseStorage.instance.ref("$foldername/$imgName");

 UploadTask uploadTask = storageRef.putData(imgPath);
 TaskSnapshot snap = await uploadTask;
 
 
 String urll = await snap.ref.getDownloadURL();
 
 return urll;
 }
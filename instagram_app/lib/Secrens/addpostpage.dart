// ignore_for_file: avoid_print, depend_on_referenced_packages, unused_import

import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/Sherd/Colors.dart';
import 'package:instagram_app/firebase_services/firebase_storg.dart';
import 'package:instagram_app/firebase_services/firestore.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  final descriptionController = TextEditingController();

  Uint8List? imgPath;
  String? imgName;
  bool post = false;

Map userpost = {};
  getData() async {
    // Get data from DB

    // setState(() {
    //   isLoading = true;
    // });
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userpost = snapshot.data()!;
    } catch (e) {
      print(e.toString());
    }
  
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  
  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   
    return imgPath != null
        ? Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      imgPath = null;
                    });
                  },
                  icon: const Icon(Icons.arrow_back)),
              actions: [
                TextButton(
                    onPressed: () async{
                      setState(() {
                        post = true;
                      });
                    await FirestoreMethod().uplodpost(
                          profileImg: userpost["profileimg"],
                          description: descriptionController.text,
                          context: context,
                          username:userpost["username"],
                          imgPath: imgPath,
                          imgName: imgName);
                           setState(() {
                        post = false;
                      });
                         setState(() {
                      imgPath = null;
                    });
                    },
                    child: const Text(
                      "post",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ))
              ],
              backgroundColor: mobileBackgroundColor,
            ),
            body: Column(
              children: [
                post
                    ? const LinearProgressIndicator()
                    : const Divider(
                        thickness: 2,
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(userpost["profileimg"]),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:  TextField(
                       controller:   descriptionController,
                        maxLines: 8,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "write a caption"),
                      ),
                    ),
                    Container(
                      width: 66,
                      height: 74,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: MemoryImage(imgPath!))),
                    ),
                  ],
                )
              ],
            ),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            body: Center(
              child: IconButton(
                  onPressed: () {
                    showmodel();
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 55,
                  )),
            ),
          );
  }
}

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, depend_on_referenced_packages

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:instagram_app/Secrens/sginin.dart';
import 'package:instagram_app/Sherd/inputdecritin.dart';
import 'package:instagram_app/Sherd/snackbar.dart';
import 'package:instagram_app/firebase_services/firebase_Auth.dart';
import 'package:instagram_app/responsive/mobilesercen.dart';
import 'package:instagram_app/responsive/responsive.dart';
import 'package:instagram_app/responsive/wepsercen.dart';
import 'package:path/path.dart' show basename;

class Rigster extends StatefulWidget {
  @override
  State<Rigster> createState() => _RigsterState();
}

class _RigsterState extends State<Rigster> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  Uint8List? imgPath;
  String? imgName;
  bool isvsable = false;
  bool isloding = false;

  // eightcharacterchanged(String password) {
  //   eightcharacter = false;
  //   Uppercase = false;
  //   Lowercase = false;
  //   onenumber = false;
  //   setState(() {
  //     if (password.contains(RegExp(r'.{8,}'))) {
  //       eightcharacter = true;
  //     }

  //     if (password.contains(RegExp(r'[a-z]'))) {
  //       Lowercase = true;
  //     }

  //     if (password.contains(RegExp(r'[A-Z]'))) {
  //       Uppercase = true;
  //     }
  //     if (password.contains(RegExp(r'[0-9]'))) {
  //       onenumber = true;
  //     }
  //   });
  // }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  uploadImage() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          // imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(33),
          child: Padding(
            padding: widthScreen > 600
                ? EdgeInsets.symmetric(horizontal: widthScreen * 0.3)
                : EdgeInsets.all(8),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                                radius: 66,
                                backgroundColor:
                                    Color.fromARGB(54, 177, 177, 177),
                                backgroundImage:
                                    AssetImage("assets/avatar.png"),
                              )
                            : CircleAvatar(
                                radius: 66,
                                backgroundImage: MemoryImage(imgPath!),
                              ),
                        Positioned(
                          left: 95,
                          bottom: -10,
                          child: IconButton(
                              onPressed: () {
                                uploadImage();
                              },
                              icon: Icon(Icons.add_a_photo)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "enter your username",
                          suffixIcon: IconButton(
                              onPressed: () {}, icon: Icon(Icons.person))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "enter your age",
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.pest_control_rodent))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value != null && !EmailValidator.validate(value)
                            ? "Enter a valid email"
                            : null;
                      },
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "enter your email",
                          suffixIcon: Icon(Icons.email)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter a valid password"
                            : null;
                      },
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: isvsable ? true : false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "enter your password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isvsable = !isvsable;
                                });
                              },
                              icon: isvsable
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()
                             &&   imgName!=null && imgPath!=null) {
                     
                          setState(() {
                            isloding = true;
                          });
                          AuthMethod().rigster(
                              eemail: emailController.text,
                              password: passwordController.text,
                              context: context,
                              username: usernameController.text,
                              age: ageController.text,
                              imgName:imgName,
                              imgPath:imgPath  );
                          setState(() {
                            isloding = false;
                          });
                          if (!mounted) return;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Responsivepage(Mobileseren: Mobilescren(), Wepseren: Wepscren(),),
                              ));
                        } else {
                          showSnackBar(context, "erorr");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: isloding
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Rigser",
                              style: TextStyle(fontSize: 19),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do you have an acount?",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child:
                                Text("sgin in", style: TextStyle(fontSize: 16)))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

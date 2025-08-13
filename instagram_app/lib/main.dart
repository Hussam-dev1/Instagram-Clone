// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';


import 'package:flutter/material.dart';
import 'package:instagram_app/Secrens/register.dart';
import 'package:instagram_app/Secrens/sginin.dart';
import 'package:instagram_app/Sherd/snackbar.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:instagram_app/responsive/mobilesercen.dart';
import 'package:instagram_app/responsive/responsive.dart';
import 'package:instagram_app/responsive/wepsercen.dart';
import 'package:provider/provider.dart';




void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      await Firebase.initializeApp(
         options: const FirebaseOptions(
        apiKey: "AIzaSyB7QVDbzEU1FRwX8YYm0nnJszdZOP7hdo0",
  authDomain: "instagram-app-53f58.firebaseapp.com",
  projectId: "instagram-app-53f58",
  storageBucket: "instagram-app-53f58.appspot.com",
  messagingSenderId: "611889867548",
  appId: "1:611889867548:web:1b6f700f7c4f21f87be8d9" ));
  } else {
 await Firebase.initializeApp(

);
  }
 runApp(const MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: CircularProgressIndicator(color: Colors.white,));} 
      else if (snapshot.hasError) {return showSnackBar(context, "Something went wrong");}
      else if (snapshot.hasData) {return Responsivepage(Mobileseren: Mobilescren(), Wepseren: Wepscren()); }
      else { return Login();}
    },
     ),
    );
  }
}

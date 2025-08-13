import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instagram_app/Secrens/Home.dart';
import 'package:instagram_app/Secrens/Serchpage.dart';
import 'package:instagram_app/Secrens/addpostpage.dart';
import 'package:instagram_app/Secrens/profilepage.dart';
import 'package:instagram_app/Sherd/Colors.dart';
import 'package:firebase_core/firebase_core.dart';

class Wepscren extends StatefulWidget {
  const Wepscren({super.key});

  @override
  State<Wepscren> createState() => _WepscrenState();
}

class _WepscrenState extends State<Wepscren> {
  final PageController pageController = PageController();
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                  setState(() {
                    page = 0;
                  });
                },
                icon: Icon(Icons.home,
                    color: page == 0 ? primaryColor : secondaryColor)),
            IconButton(
                onPressed: () {
                  pageController.jumpToPage(1);
                  setState(() {
                    page = 1;
                  });
                },
                icon: Icon(Icons.search,
                    color: page == 1 ? primaryColor : secondaryColor)),
            IconButton(
                onPressed: () {
                  pageController.jumpToPage(2);
                  setState(() {
                    page = 2;
                  });
                },
                icon: Icon(Icons.add_a_photo,
                    color: page == 2 ? primaryColor : secondaryColor)),
            IconButton(
                onPressed: () {
                  pageController.jumpToPage(3);
                  setState(() {
                    page = 3;
                  });
                },
                icon: Icon(Icons.add_circle,
                    color: page == 3 ? primaryColor : secondaryColor)),
            IconButton(
                onPressed: () {
                  pageController.jumpToPage(4);
                  setState(() {
                    page = 4;
                  });
                },
                icon: Icon(Icons.person,
                    color: page == 4 ? primaryColor : secondaryColor)),
          ],
         ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Home(),
          Serch(),
          Addpost(),
          Text("pp"),
          Profile(uid: FirebaseAuth.instance.currentUser!.uid,),
        ],
      ),
    );
  }
}

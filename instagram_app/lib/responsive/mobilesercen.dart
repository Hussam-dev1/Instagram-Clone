// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Secrens/Home.dart';
import 'package:instagram_app/Secrens/Serchpage.dart';
import 'package:instagram_app/Secrens/addpostpage.dart';
import 'package:instagram_app/Secrens/comment%20scren.dart';
import 'package:instagram_app/Secrens/profilepage.dart';
import 'package:instagram_app/Sherd/Colors.dart';
import 'package:firebase_core/firebase_core.dart';

class Mobilescren extends StatefulWidget {
  const Mobilescren({super.key});

  @override
  State<Mobilescren> createState() => _MobilescrenState();
}

class _MobilescrenState extends State<Mobilescren> {
  final PageController pageController = PageController();

  int curntpage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
          onTap: (index) {
            pageController.jumpToPage(index);
            setState(() {
              curntpage = index;
            });
          },
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.home,
                  color: curntpage == 0 ? primaryColor : secondaryColor),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.search,
                  color: curntpage == 1 ? primaryColor : secondaryColor),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.add_circle,
                  color: curntpage == 2 ? primaryColor : secondaryColor),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.favorite,
                  color: curntpage == 3 ? primaryColor : secondaryColor),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.person,
                  color: curntpage == 4 ? primaryColor : secondaryColor),
            ),
          ]),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          commentscren(),
          Home(),
          Serch(),
          Addpost(),
          Text("pp"),
          Profile(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
        ],
      ),
    );
  }
}

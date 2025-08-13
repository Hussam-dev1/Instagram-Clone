// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instagram_app/Sherd/Colors.dart';
import 'package:instagram_app/Sherd/post_desgin.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  @override
  Widget build(BuildContext context) {
   
    final double widthScreen = MediaQuery.of(context).size.width;
   
    return Scaffold(
      backgroundColor:
          widthScreen > 600 ? webBackgroundColor : mobileBackgroundColor,
      appBar: widthScreen > 600
          ? null
          : AppBar(
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.messenger_outline,
                    )),
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                    )),
              ],
              backgroundColor: mobileBackgroundColor,
            ),
      body:    
     StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: Colors.white,);
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: mobileBackgroundColor,
        ),
        margin: EdgeInsets.symmetric(
            vertical: 11, horizontal: widthScreen > 600 ? widthScreen / 4 : 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundImage: AssetImage(
                             "assets/360_F_524300228_egMskw0zvvdwNUFPeJLlplclKzFamXBk.jpg",),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(""),
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert))
                ],
              ),
            ),
            Image.asset(
              "assets/360_F_524300228_egMskw0zvvdwNUFPeJLlplclKzFamXBk.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.message)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
              ],
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 0, 10),
                width: double.infinity,
                child:  Text(
                  "10 like",
                  style: TextStyle(color: Colors.white38),
                )),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child:  Text("allDataFromDB.username")),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child:  Text("")),
              ],
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: const Text(
                      "username",
                      style: TextStyle(color: Colors.white38),
                    ))),
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: double.infinity,
              child: const Text(
                "16 oct 2023",
                style: TextStyle(color: Colors.white38),
              ),
            )
          ],
        ),
      );
          }).toList(),
        );
      },
    )
    );
  }
}

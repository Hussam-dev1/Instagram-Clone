import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Secrens/profilepage.dart';
import 'package:instagram_app/Sherd/Colors.dart';

class Serch extends StatefulWidget {
  const Serch({super.key});

  @override
  State<Serch> createState() => _SerchState();
}

class _SerchState extends State<Serch> {
  final controler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {});
          },
          controller: controler,
          decoration: InputDecoration(labelText: "serch for user"),
        ),
        backgroundColor: mobileBackgroundColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('User')
            .where("username", isEqualTo: controler.text)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(uid: (snapshot.data!.docs[index]["uid"],),
                                ),
                        )
                        );
                      },
                      title: Text(snapshot.data!.docs[index]["username"]),
                      leading: CircleAvatar(
                          radius: 33,
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index]["profileimg"])));
                });
          }

          return Center(child: CircularProgressIndicator(color: Colors.white,));
        },
      ),
    );
  }
}

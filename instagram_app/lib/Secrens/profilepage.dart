import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Sherd/Colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.uid});
  // ignore: prefer_typing_uninitialized_variables
  final uid;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map userData = {};
  bool isLoading = true;
  int follwers=0;
  int following=0;
 bool showfollow=false;


  getData() async {
    // Get data from DB

    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('User')
          .doc(widget.uid)
          .get();

      userData = snapshot.data()!;
    } catch (e) {
      print(e.toString());
    }
    follwers=userData["follwers"].length;
    following=userData["following"].length;
    showfollow=userData["follwers"].contains(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isLoading = false;
    });
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
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.white,
          ))
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData["username"]),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 50, 10),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(userData["profileimg"]),
                      ),
                    ),
                    const Column(
                      children: [
                        Text(
                          "1",
                          style: TextStyle(fontSize: 23),
                        ),
                        Text(
                          "post",
                          style: TextStyle(fontSize: 19, color: Colors.white54),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                     Column(
                      children: [
                        Text(
                          follwers.toString(),
                          style: TextStyle(fontSize: 23),
                        ),
                        Text(
                          "follwers",
                          style: TextStyle(fontSize: 19, color: Colors.white54),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                     Column(
                      children: [
                        Text(
                          following.toString(),
                          style: TextStyle(fontSize: 23),
                        ),
                        Text(
                          "following",
                          style: TextStyle(fontSize: 19, color: Colors.white54),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 19),
                    child: Text(
                      userData["age"],
                      style: TextStyle(fontSize: 17),
                    )),
                const SizedBox(
                  height: 20,
                ),
                widget.uid==FirebaseAuth.instance.currentUser!.uid?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                      label: const Text(
                        "Edit profile",
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(0, 90, 103, 223)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: widthScreen > 600 ? 19 : 10,
                            horizontal: 33)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: const BorderSide(
                                color: Color.fromARGB(109, 255, 255, 255),
                                // width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.logout,
                        size: 24.0,
                      ),
                      label: const Text(
                        "Log out",
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(143, 255, 55, 112)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: widthScreen > 600 ? 19 : 10,
                            horizontal: 33)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                :
         showfollow==true?       ElevatedButton(
   onPressed: ()async{
    await FirebaseFirestore.instance.collection("User").doc(widget.uid).update({"follwers": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])});
 
//To remove from a list
await FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).update({"follwers": FieldValue.arrayUnion([widget.uid])});

   },
   style: ButtonStyle(
     backgroundColor: MaterialStateProperty.all(Colors.orange),
     padding: MaterialStateProperty.all(EdgeInsets.all(12)),
     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
   child: Text("click here", style: TextStyle(fontSize: 19),) ,
   
):
ElevatedButton(
   onPressed: ()async{
    await FirebaseFirestore.instance.collection("User").doc(widget.uid).update({"follwers": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])});
 
//To remove from a list
await FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).update({"follwers": FieldValue.arrayRemove([widget.uid])});

   },
   style: ButtonStyle(
     backgroundColor: MaterialStateProperty.all(Colors.orange),
     padding: MaterialStateProperty.all(EdgeInsets.all(12)),
     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
   child: Text("click here", style: TextStyle(fontSize: 19),) ,
   
),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 10),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                                "assets/360_F_524300228_egMskw0zvvdwNUFPeJLlplclKzFamXBk.jpg",
                                fit: BoxFit.cover),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }
}

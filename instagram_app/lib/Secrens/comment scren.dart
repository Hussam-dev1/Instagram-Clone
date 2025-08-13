// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:instagram_app/Sherd/Colors.dart';
import 'package:instagram_app/Sherd/inputdecritin.dart';

class commentscren extends StatefulWidget {
  const commentscren({super.key});

  @override
  State<commentscren> createState() => _commentscrenState();
}

class _commentscrenState extends State<commentscren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: Text(
          "comments",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: mobileBackgroundColor,
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Container(
                //   margin: EdgeInsets.only(right: 12),
                //   padding: EdgeInsets.all(5),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Color.fromARGB(125, 78, 91, 110),
                //   ),
                //   child: CircleAvatar(
                //     backgroundImage: NetworkImage(
                //         "https://cdn1-m.zahratalkhaleej.ae/store/archive/image/2020/11/4/813126b3-4c9d-4a7b-b8d9-83f46749fa26.jpg?format=jpg&preset=w1900"),
                //     radius: 26,
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("USERNAME",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        SizedBox(
                          width: 11,
                        ),
                        Text("nice pic ♥♥",
                            style: const TextStyle(fontSize: 16))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("12/12/2012",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              // Container(
              //   margin: EdgeInsets.only(right: 12),
              //   padding: EdgeInsets.all(5),
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Color.fromARGB(125, 78, 91, 110),
              //   ),
              //   child: CircleAvatar(
              //     backgroundImage: NetworkImage(
              //         "https://cdn1-m.zahratalkhaleej.ae/store/archive/image/2020/11/4/813126b3-4c9d-4a7b-b8d9-83f46749fa26.jpg?format=jpg&preset=w1900"),
              //     radius: 26,
              //   ),
              // ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                      hintText: "Commnet As Hussam:", suffixIcon:IconButton(onPressed: () {
                        
                      }, icon: Icon(Icons.send)) ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

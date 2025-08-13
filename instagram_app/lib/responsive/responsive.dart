import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Responsivepage extends StatefulWidget {
  final Mobileseren;
  final Wepseren;

  const Responsivepage({super.key, required this.Mobileseren, required this.Wepseren});

  @override
  State<Responsivepage> createState() => _ResponsivepageState();
}

class _ResponsivepageState extends State<Responsivepage> {
  // To get data from DB using provider

 
 
//  @override

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext, BoxConstraints) {
      if (BoxConstraints.maxWidth > 600) {
        return widget.Wepseren;
      } else {
      return widget.Mobileseren;
      }
    });
  }
}

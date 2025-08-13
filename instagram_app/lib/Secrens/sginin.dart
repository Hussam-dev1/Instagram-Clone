
import 'package:flutter/material.dart';



import 'package:instagram_app/Secrens/register.dart';
import 'package:instagram_app/Sherd/inputdecritin.dart';
import 'package:instagram_app/firebase_services/firebase_Auth.dart';


class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isvisble = false;
  bool isloding = false;
  // signin() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       showSnackBar(context, 'No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       showSnackBar(context, 'wrong password.');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
     final double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Padding(
               padding: widthScreen>600? EdgeInsets.symmetric(horizontal: 230):EdgeInsets.all(8),
                child: SingleChildScrollView(
              child: Column(mainAxisAlignment:MainAxisAlignment.center, children: [
                TextField(
            controller: emailController,
            keyboardType: TextInputType.text,
            obscureText: false,
            decoration: decorationTextfield.copyWith(
                hintText: "enter your email", suffixIcon: Icon(Icons.email)),
                ),
                SizedBox(
            height: 25,
                ),
                TextField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isvisble ? false : true,
            decoration: decorationTextfield.copyWith(
                hintText: "enter your password",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isvisble = !isvisble;
                      });
                    },
                    icon: isvisble
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility))),
                ),
                SizedBox(
            height: 25,
                ),
                TextButton(
              onPressed: () {
              
              },
              child: Text(
                "Forget your passwaord?",
                style: TextStyle(fontSize: 15, color: Colors.blue),
              )),
                ElevatedButton(
            onPressed: () async {
              setState(() {
                isloding = true;
              });
              await AuthMethod().Sginin(email: emailController.text, pasword: passwordController.text,context: context);
              setState(() {
                isloding = false;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              "sign in",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
                ),
                SizedBox(
            height: 20,
                ),
                Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don`t have an acount?",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Rigster(),
                      ),
                    );
                  },
                  child: Text("sgin up",
                      style: TextStyle(fontSize: 16, color: Colors.blue)))
            ],
                ),
              ]),
                ),
              ),
          )),
    );
  }
}

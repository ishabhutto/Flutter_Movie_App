import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_example/Text/heading.dart';
import 'package:movie_app_example/Text/text.dart';
import 'package:movie_app_example/authservice.dart';

import 'package:movie_app_example/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernamecont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passconcont = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;

  final AuthService authService = AuthService();
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  signUp() async {
    final User? user = await authService.signUp(emailcont.text, passcont.text);

    if (user != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign up")));
    }
    users.add({
      "email": emailcont.text,
      "name": usernamecont.text,
    });
  }

  void emptyfield() {
    emailcont.text = "";
    passcont.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Modified_Text2(
          text: 'SignUp',
          color: Colors.red,
          size: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(4),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF292B37),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: usernamecont,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your Name",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF292B37),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: emailcont,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your Email Address",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter some text";
                    } else if (!value.endsWith('gmail.com')) {
                      return "Please enter correct Gmail Extention";
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF292B37),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  obscureText: _obscureText,
                  controller: passcont,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter new Password",
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // Toggle the state
                        });
                      },
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter a password";
                    }

                    // Ensure it contains at least one uppercase letter
                    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                      return 'Password must contain at least one uppercase letter.';
                    }

                    // Ensure it contains at least one lowercase letter
                    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                      return 'Password must contain at least one lowercase letter.';
                    }

                    // Ensure it contains at least one digit
                    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
                      return 'Password must contain at least one digit.';
                    }

                    // Ensure it contains at least one special character
                    if (!RegExp(r'^(?=.*[@#$%^&+=])').hasMatch(value)) {
                      return 'Password must contain at least one special character.';
                    }

                    // Ensure it is at least 8 characters long
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF292B37),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  obscureText: _obscureText2,
                  controller: passconcont,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2; // Toggle the state
                        });
                      },
                      icon: Icon(_obscureText2
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please confirm your password";
                    }
                    if (passconcont.text != passcont.text) {
                      return "Password and confirm pass must bs same";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonTheme(
                  minWidth: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          signUp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(16),
                          minimumSize: const Size(160, 50)),
                      child: const Text("SignUp"))),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Modified_Text(
                    text: "Already have an Account? Login",
                    color: Colors.red,
                    size: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_example/Text/heading.dart';
import 'package:movie_app_example/Text/text.dart';
import 'package:movie_app_example/authservice.dart';
import 'package:movie_app_example/homepage.dart';
import 'package:movie_app_example/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginPageState();
}

class LoginPageState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passcont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  bool _obscureText = true;
  final AuthService authService = AuthService();
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  delUser(String docid) {
    users.doc(docid).delete();
  }

  signIn() async {
    final User? user = await authService.signIn(emailcont.text, passcont.text);

    if (user != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign IN")));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No such user found")));
    }
  }

  updatepass() {
    authService.resetPassword(emailcont.text);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Check you have recieved email")));
  }

  void emptyfield() {
    emailcont.text = "";
    passcont.text = "";
  }

  @override
  Widget build(BuildContext context) {
    String un = "";
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Modified_Text2(
            text: 'Login',
            color: Colors.red,
            size: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: screenSize.height * 0.1,
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
                      hintText: "Email",
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
                  height: 30,
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
                      hintText: "Password",
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
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      signIn();
                      emptyfield();
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
                  child: const Text("Login"),
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUp()));
                    },
                    child: const Modified_Text(
                      text: "Dont have an Account? SignUp",
                      color: Colors.red,
                      size: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
                TextButton(
                    onPressed: () {
                      if (emailcont.text.isNotEmpty) {
                        updatepass();
                      }
                    },
                    child: const Modified_Text(
                      text: "Forgotten Password?",
                      color: Colors.red,
                      size: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ));
  }
}

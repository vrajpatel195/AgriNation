import 'package:agri/screens/forgot_password.dart';
import 'package:agri/screens/home_screen.dart';
import 'package:agri/screens/signup_screen.dart';
import 'package:agri/services/firebase_auth_service.dart';
import 'package:agri/widgets/customized_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/customized_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF62DACA), Color(0xFF2FBF71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Welcome Back! Glad \nto see you again",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CustomizedTextfield(
                  myController: _emailController,
                  hintText: "Enter your Email",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Enter your Password",
                  isPassword: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 71, 81),
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
                CustomizedButton(
                  buttonText: "Login",
                  buttonColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      await FirebaseAuthService().login(
                          _emailController.text.trim(),
                          _passwordController.text.trim());
                      if (FirebaseAuth.instance.currentUser != null) {
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }
                    } on FirebaseException catch (e) {
                      debugPrint("error is ${e.message}");

                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: const Text(
                                      " Invalid Username or password. Please register again or make sure that username and password is correct"),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text("Register Now"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpScreen()));
                                      },
                                    )
                                  ]));
                    }

                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.15,
                        color: Colors.grey,
                      ),
                      const Text("Or Login with"),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Container(
                      //     height: 50,
                      //     width: 100,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.black, width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: IconButton(
                      //       icon: const Icon(
                      //         FontAwesomeIcons.facebookF,
                      //         color: Colors.blue,
                      //       ),
                      //       onPressed: () {},
                      //     )),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            // color: Colors.blue,
                          ),
                          onPressed: () async {
                            await FirebaseAuthService().logininwithgoogle();

                            if (FirebaseAuth.instance.currentUser != null) {
                              if (!mounted) return;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            } else {
                              throw Exception("Error");
                            }
                          },
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.apple,
                              // color: Colors.blue,
                            ),
                            onPressed: () {},
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(
                            color: Color(0xff1E232C),
                            fontSize: 15,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text("  Register Now",
                            style: TextStyle(
                              color: Color.fromARGB(255, 14, 53, 117),
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

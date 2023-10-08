// import 'package:firebase_auth101/services/firebase_auth_service.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:agri/screens/home_screen.dart';
import 'package:agri/services/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/customized_button.dart';
import '../widgets/customized_textfield.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await user!.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  bool isEmailVerified() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null && user.emailVerified;
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        // Handle sign-in failure
        throw Exception("Error");
      }
    } catch (error) {
      print(error.toString());
      // Handle error
    }
  }

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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
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
                  child: Text("Hello!  Register to get \nStarted",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CustomizedTextfield(
                  myController: _usernameController,
                  hintText: "Username",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _emailController,
                  hintText: "Email",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Password",
                  isPassword: true,
                ),
                CustomizedTextfield(
                  myController: _confirmPasswordController,
                  hintText: "Confirm Password",
                  isPassword: true,
                ),
                CustomizedButton(
                  buttonText: "Register",
                  buttonColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    await signUpWithEmailPassword(email, password);
                    await sendEmailVerification();
                    if (isEmailVerified()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    } else {
                      print('Not Verified');
                    }
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const LoginScreen()));
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
                      const Text("Or Register with"),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.16,
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
                          onPressed: _handleGoogleSignIn,

                          // if (user != null) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => const HomeScreen()));
                          // } else {
                          //   throw Exception("Error");
                          // }
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
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(
                            color: Color(0xff1E232C),
                            fontSize: 15,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
                        },
                        child: const Text("  Login Now",
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

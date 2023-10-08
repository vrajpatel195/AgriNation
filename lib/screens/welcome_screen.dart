import 'package:agri/screens/home_screen.dart';
import 'package:agri/screens/login_screen.dart';
import 'package:agri/screens/signup_screen.dart';
import 'package:agri/widgets/customized_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: double.infinity,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(image: AssetImage("assets/background.png"))),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF62DACA), Color(0xFF2FBF71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 130,
              width: 180,
              child: Image(
                  image: AssetImage("assets/logo1.png"), fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            CustomizedButton(
              buttonText: "Login",
              buttonColor: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
            CustomizedButton(
              buttonText: "Register",
              buttonColor: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: MyTextButton(),
            )
          ],
        ),
      ),
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Replace with your actual login logic
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      },
      child: const Text(
        'Continue as a Guest',
        style: TextStyle(
          fontSize: 20.0,
          color: Color.fromARGB(255, 11, 72, 122),
          decoration: TextDecoration.underline,
          decorationColor: Color.fromARGB(255, 11, 72, 122),
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 20), // Set padding here
        ),
      ),
    );
  }
}

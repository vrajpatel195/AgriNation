import 'package:agri/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agri/Page/info_card.dart';

// our data

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  final String? email = FirebaseAuth.instance.currentUser?.email;
  final String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF4A9967), Color(0xFF206D3D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
        ),
        //backgroundColor: Colors.blueGrey[800],
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFF62DACA), Color(0xFF2FBF71)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: SafeArea(
            minimum: const EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user!.photoURL ?? 'assets/camera.png',
                  ),
                ),
                Text(
                  "$userName",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFF206D3D),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico",
                  ),
                ),
                // Text(
                //   "Flutter Developer",
                //   style: TextStyle(
                //       fontSize: 30,
                //       color: Colors.blueGrey[200],
                //       letterSpacing: 2.5,
                //       fontWeight: FontWeight.bold,
                //       fontFamily: "Source Sans Pro"),
                // ),
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),

                // we will be creating a new widget name info carrd

                InfoCard(
                    text: '$phone', icon: Icons.phone, onPressed: () async {}),
                //InfoCard(text: url, icon: Icons.web, onPressed: () async {}),
                // InfoCard(
                //     text: location,
                //     icon: Icons.location_city,
                //     onPressed: () async {}),
                InfoCard(
                    text: '$email', icon: Icons.email, onPressed: () async {}),
              ],
            ),
          ),
        ));
  }
}

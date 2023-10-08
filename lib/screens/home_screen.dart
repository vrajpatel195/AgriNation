import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'package:agri/input/image_input.dart';
import 'package:agri/drawer/side_menu_list.dart';
import 'package:agri/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key? key}) : super(key: key);
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  bool? isLogin;
  var user = FirebaseAuth.instance.currentUser;
  String imageUrl = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<SideMenuState> sideMenukey = GlobalKey<SideMenuState>();

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      isLogin = false;
    } else {
      isLogin = true;
    }
    return SideMenu(
      key: sideMenukey,
      background: Color(0xFF206D3D),
      menu: SideMenuList(
        menuKey: sideMenukey,
      ),
      maxMenuWidth: 330,
      type: SideMenuType.shrinkNSlide,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashColor: Colors.white,
            iconSize: 32,
            onPressed: () {
              if (sideMenukey.currentState!.isOpened) {
                sideMenukey.currentState!.closeSideMenu();
              } else {
                sideMenukey.currentState!.openSideMenu();
              }
            },
            icon: Icon(Icons.menu),
          ),
          title: const Text(
            " Agrination",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            if (!isLogin!)
              IconButton(
                onPressed: () {
                  isLogin = true; // Replace with your actual login logic
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                },
                icon: const Icon(Icons.login),
                color: Colors.white,
                iconSize: 30,
                splashColor: Colors.green,
              )
            else
              IconButton(
                onPressed: () async {
                  await clearUserData();
                  await clearCache();
                  await _auth.signOut();

                  if (!mounted) return;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                },
                icon: const Icon(Icons.logout),
              )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF4A9967), Color(0xFF206D3D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
        ),
        body: ImageInput(onFileChanged: (imageUrl) {
          setState(() {
            this.imageUrl = imageUrl;
          });
        }),
      ),
    );
  }
}

// void clearCache() async{
// var appDir = (await getTemporaryDirectory()).path;
// new Directory(appDir).delete(recursive: true);
// }


import 'package:agri/Page/profile_page.dart';
import 'package:agri/main.dart';
import 'package:agri/screens/home_screen.dart';
import 'package:agri/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SideMenuList extends StatefulWidget {
  final GlobalKey<SideMenuState> menuKey;
  const SideMenuList({super.key, required this.menuKey});

  @override
  State<SideMenuList> createState() => _SideMenuListState();
}

class _SideMenuListState extends State<SideMenuList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  final String? email = FirebaseAuth.instance.currentUser?.email;

  bool? isLogin;

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      isLogin = false;
    } else {
      isLogin = true;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 20),
      child: ListView(
        children: [
          if (isLogin!)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 1),
              leading: CircleAvatar(
                maxRadius: 40,
                backgroundImage: NetworkImage(
                  user!.photoURL ?? 'assets/guest1.png',
                ),
              ),
              title: Text(
                '$userName',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "$email",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          else
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 18),
              leading: CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: AssetImage('assets/guest1.png')),
              title: MyTextButton(),
              subtitle: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            color: Colors.black54,
          ),
          const SizedBox(
            height: 18,
          ),
          buttonDecoration(
              name: 'Home Screen',
              iconData: Icons.home,
              boxColor: Colors.orange.shade300,
              onTap: () {
                if (widget.menuKey.currentState!.isOpened) {
                  widget.menuKey.currentState!.closeSideMenu();
                } else {
                  widget.menuKey.currentState!.openSideMenu();
                }
              }),
          const SizedBox(
            height: 20,
          ),
          buttonDecoration(
              name: 'Profile',
              iconData: Icons.person,
              boxColor: const Color.fromRGBO(0, 0, 0, 0),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }),
          const SizedBox(
            height: 20,
          ),
          // buttonDecoration(
          //     name: 'My WishList',
          //     iconData: Icons.favorite,
          //     boxColor: Colors.transparent,
          //     onTap: () {}),
          // const SizedBox(
          //   height: 20,
          // ),
          // buttonDecoration(
          //     name: 'My Order',
          //     iconData: Icons.shopping_bag,
          //     boxColor: Colors.transparent,
          //     onTap: () {}),
          // const SizedBox(
          //   height: 20,
          // ),
          // buttonDecoration(
          //     name: 'Notifications',
          //     iconData: Icons.notifications,
          //     boxColor: Colors.transparent,
          //     onTap: () {}),
          // const SizedBox(
          //   height: 12,
          // ),
          const Divider(
            color: Colors.black54,
          ),
          const SizedBox(
            height: 18,
          ),
          if (!isLogin!)
            buttonDecoration(
                name: 'Login',
                iconData: Icons.login,
                boxColor: Colors.transparent,
                onTap: () {
                  isLogin = true; // Replace with your actual login logic
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                })
          else
            buttonDecoration(
                name: 'LogOut',
                iconData: Icons.logout,
                boxColor: Colors.transparent,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await _auth.signOut();
                  if (!mounted) return;
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                })
        ],
      ),
    );
  }

  buttonDecoration({
    required String name,
    required IconData iconData,
    required VoidCallback onTap,
    required Color boxColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: boxColor,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 27,
              color: Colors.orange,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
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
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      },
      child: const Text(
        'Login/Signup',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue,
          decoration: TextDecoration.underline,
          decorationColor: Colors.blue,
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

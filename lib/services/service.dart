import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    return null; // User canceled the sign-in process
  }

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  try {
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;
    return user;
  } catch (error) {
    print(error.toString());
    return null;
  }
}

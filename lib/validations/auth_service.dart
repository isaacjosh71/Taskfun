
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../foundation/root_page.dart';

class AuthClass {
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();


  Future<String> getCurrentUID() async {
    return auth.currentUser!.uid;
  }

  Future<void> googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn()
        .signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    try {
      UserCredential userCredential = await auth.signInWithCredential(
          credential);
      storeTokenAndDta(userCredential);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (builder) => const RootPage()), (route) => false);
    } catch (e) {
      final snackBar = const SnackBar(content: Text('Unable to sign in'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e.toString());
    }
  }

  Future<void> storeTokenAndDta(UserCredential userCredential) async {
    await storage.write(key: 'token', value: userCredential.user!.uid);
    print(userCredential.user!.uid);
    await storage.write(
        key: 'userCredential', value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
    await storage.delete(key: 'token');
  }
}
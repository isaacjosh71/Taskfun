
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../foundation/root_page.dart';

class AuthClass{
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();


  Future<String> getCurrentUID() async{
    return auth.currentUser!.uid;
  }

  Future<void> googleSignIn(BuildContext context) async {
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount!= null){
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try{
          UserCredential userCredential = await auth.signInWithCredential(credential);
          storeTokenAndDta(userCredential);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (builder)=> const RootPage()), (route) => false);
        } catch(e){
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      else {
        const snackBar = SnackBar(content: Text('Unable to sign in'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch(e){
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<void> storeTokenAndDta(UserCredential userCredential) async {
    await storage.write(key: 'token', value: userCredential.credential?.token.toString());
    await storage.write(key: 'userCredential', value: userCredential.toString());
  }
  Future<String?> getToken () async{
    return await storage.read(key: 'token');
  }
  Future<void> logOut()async {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: 'token');
  }
  Future<void>verifyPhoneNumber(String phoneNumber, BuildContext context, Function setData)
  async {
     verificationCompleted (PhoneAuthCredential phoneAuthCredential)async{
      showSnackBar(context, 'Verification Completed');
    }
     verificationFailed(FirebaseAuthException exception){
      showSnackBar(context, exception.toString());
    }
    codeSent(String verificationID, [int? forceResendingToken]){
      showSnackBar(context, 'Verification code sent to the phone number');
      setData(verificationID);
    }
    codeAutoRetrievalTimeout(String verificationID){
      showSnackBar(context, 'Time Out');
        }

    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
  Future<void> signInWithPhoneNumber(String verificationId, String smsCode, BuildContext context)async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    UserCredential userCredential = await auth.signInWithCredential(credential);
    storeTokenAndDta(userCredential);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (builder)=> const RootPage()), (route) => false);
    showSnackBar(context, 'signed in');
  }
  void showSnackBar(BuildContext context, String text){
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
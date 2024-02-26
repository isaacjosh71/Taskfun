

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../foundation/root_page.dart';
import '../validations/forgot_password.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  final storage = const FlutterSecureStorage();

  Future<String?> getToken () async{
    return await storage.read(key: 'token');
  }

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body:
            SafeArea(
              minimum: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                      child: const Text('Welcome Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2B3849),
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height * 0.035,
                                  left: MediaQuery.of(context).size.width * 0.025,
                                  right: MediaQuery.of(context).size.width * 0.025),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)){
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _mailController,
                                cursorColor: Colors.black,
                                showCursor: true,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: const Color(0xFF5C85C1).withOpacity(0.7)
                                    ),
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: const Color(0xFF5C85C1).withOpacity(0.3)
                                    ),
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Get.isDarkMode ? Colors.white: Colors.black87,
                                  ),
                                  prefixIcon: Icon(Icons.email_outlined,
                                    size: 17, color: Get.isDarkMode ? Colors.white: Colors.black87,),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height * 0.035,
                                  left: MediaQuery.of(context).size.width * 0.025,
                                  right: MediaQuery.of(context).size.width * 0.025),
                              child: TextFormField(
                                key: const ValueKey('password'),
                                validator: (value){
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (_passController.text.length < 6){
                                    return 'Enter at least 5 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value){},
                                controller: _passController,
                                cursorColor: Get.isDarkMode ? Colors.white:  Colors.black,
                                showCursor: true,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: const Color(0xFF5C85C1).withOpacity(0.7)
                                    ),
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: const Color(0xFF5C85C1).withOpacity(0.3)
                                    ),
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Get.isDarkMode ? Colors.white: Colors.black87,
                                  ),
                                  prefixIcon: Icon(Icons.lock_open_rounded,
                                    size: 18, color: Get.isDarkMode ? Colors.white: Colors.black87,),
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _obscureText =!_obscureText;
                                      });
                                    },
                                    child: Icon(_obscureText? Icons.visibility
                                        : Icons.visibility,
                                        size: 18,color: Get.isDarkMode ? Colors.white: Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,
                                  top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF455A64),
                                    ),),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                          builder: (builder)=> const ForgotPassword()), (route) => false);
                                    },
                                    child: Text('click here',
                                      style: TextStyle(color: const Color(0xFF5C85C1).withOpacity(0.9),
                                          fontSize: 19),),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.045),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.58),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all<double>(
                                        5,),
                                      shadowColor: MaterialStateProperty.all<Color>(
                                          Colors.grey),
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        const Color(0xFF5C85C1).withOpacity(0.5),)
                                  ),
                                  child: const Text('Log In',
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 20),),
                                  onPressed: () async{
                                    try {
                                      if(_formKey.currentState!.validate()){
                                        UserCredential userCredential =
                                        await firebaseAuth.signInWithEmailAndPassword(
                                            email: _mailController.text, password: _passController.text);
                                        storeTokenAndDta(userCredential);
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                            builder: (builder)=> const RootPage()), (route) => false);
                                      }
                                    }
                                        catch(e){
                                          final snackBar = SnackBar(content: Text(e.toString()));
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
  Future<void> storeTokenAndDta(UserCredential userCredential) async {
    await storage.write(key: 'token', value: userCredential.user!.uid);
    print(userCredential.user!.uid);
    await storage.write(key: 'userCredential', value: userCredential.toString());
  }
}





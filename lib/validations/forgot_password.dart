

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:task_me/validations/log_in.dart';
import '../foundation/root_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _mailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body:
      SafeArea(
        minimum: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                child: const Text('Forgot Password',
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
                          cursorColor:  Get.isDarkMode ? Colors.white : Colors.black,
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
                            labelStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF455A64),
                            ),
                            prefixIcon: Icon(Icons.email_outlined,
                              size: 17, color:  Get.isDarkMode ? Colors.white : Colors.black87,),
                          ),
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
                            child: const Text('Reset',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20),),
                            onPressed: () async{
                              showDialog(context: context,
                                  barrierDismissible: false,
                                  builder: (context){
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                                  });
                              try {
                                if(_formKey.currentState!.validate()){
                                  await firebaseAuth.sendPasswordResetEmail(email: _mailController.text);
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                      builder: (builder)=> const LogIn()), (route) => false);
                                  const snackBar = SnackBar(content: Text('Password Reset Email Sent'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}





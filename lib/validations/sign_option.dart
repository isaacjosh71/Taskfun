
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_me/validations/log_option.dart';
import 'package:task_me/validations/phone_page.dart';
import 'package:task_me/validations/sign_up.dart';
import 'package:task_me/validations/auth_service.dart';

class SignOption extends StatefulWidget {
  const SignOption({Key? key}) : super(key: key);

  @override
  State<SignOption> createState() => _SignOptionState();
}

class _SignOptionState extends State<SignOption> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFEF9),
      body:
            SafeArea(
              minimum: EdgeInsets.only(top:
              MediaQuery.of(context).size.height * 0.25
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                      child: const Text('Create An Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2B3849),
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              await authClass.googleSignIn(context);
                            },
                            child: Card(
                              color: Colors.white.withOpacity(0.97),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide.none
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/g.png',
                                    height:
                                    MediaQuery.of(context).size.height * 0.06
                                  ),
                                  const SizedBox(width: 7,),
                                  Text('Continue with google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Get.isDarkMode?Colors.black:Colors.black
                                  ),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (builder)=> const SignUp()));
                            },
                            child: Card(
                              color: Colors.white.withOpacity(0.97),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide.none
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/mail.png',
                                    height: MediaQuery.of(context).size.height * 0.06
                                  ),
                                  const SizedBox(width: 7),
                                  Text('Use email and password',
                                  style: TextStyle(
                                    fontSize: 18,
                                      color: Get.isDarkMode?Colors.black:Colors.black
                                  ),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (builder)=> const PhonePage()));
                            },
                            child: Card(
                              color: Colors.white.withOpacity(0.97),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide.none
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/phone.png',
                                    height: MediaQuery.of(context).size.height * 0.05
                                  ),
                                  const SizedBox(width: 7),
                                   Text('Use phone number',
                                  style: TextStyle(
                                    fontSize: 18,
                                      color: Get.isDarkMode?Colors.black:Colors.black
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07,
                          top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Already have an account?',
                            style: TextStyle(color: Color(0xFF455A64),
                                fontSize: 17),),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (builder)=> const LogOption()), (route) => false);
                            },
                            child: Text('log in',
                              style: TextStyle(color: const Color(0xFF5C85C1).withOpacity(0.9),
                                  fontSize: 19),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

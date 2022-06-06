
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_me/validations/auth_service.dart';
import 'package:task_me/validations/log_in.dart';
import 'package:task_me/validations/phone_page.dart';
import 'package:task_me/validations/sign_option.dart';

class LogOption extends StatefulWidget {
  const LogOption({Key? key}) : super(key: key);

  @override
  State<LogOption> createState() => _LogOptionState();
}

class _LogOptionState extends State<LogOption> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFEF9),
      body:
            SafeArea(
              minimum: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
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
                                    height: MediaQuery.of(context).size.height * 0.06,
                                  ),
                                  const SizedBox(width: 7),
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
                                  builder: (builder)=> const LogIn()));
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
                                    height: MediaQuery.of(context).size.height * 0.06,
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
                                    height: MediaQuery.of(context).size.height * 0.05,
                                  ),
                                  const SizedBox(width: 10,),
                                Text('Use phone number',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Get.isDarkMode?Colors.black:Colors.black
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.005,
                                top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Don\'t have an account?',
                                  style: TextStyle(color: Color(0xFF455A64),
                                      fontSize: 17),),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                        builder: (builder)=> const SignOption()), (route) => false);
                                  },
                                  child: Text('sign up',
                                    style: TextStyle(color: const Color(0xFF5C85C1).withOpacity(0.9),
                                        fontSize: 19),),
                                ),
                              ],
                            ),
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

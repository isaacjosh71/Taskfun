//
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/otp_field_style.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:task_me/validations/auth_service.dart';
//
// import '../foundation/root_page.dart';
//
// class PhonePage extends StatefulWidget {
//   const PhonePage({Key? key}) : super(key: key);
//   @override
//   State<PhonePage> createState() => _PhonePageState();
// }
//
// class _PhonePageState extends State<PhonePage> {
//   int start = 60;
//   bool wait = false;
//   String buttonName = 'send';
//   final TextEditingController _phoneController = TextEditingController();
//   AuthClass authClass = AuthClass();
//   String verificationIdFinal = '';
//   String smsCode = '';
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final storage = const FlutterSecureStorage();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.theme.backgroundColor,
//       body:
//             SafeArea(
//               minimum: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
//                       child: const Text('Create Your Account',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xFF2B3849),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 28,
//                         ),),
//                     ),
//                    SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.015,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(17),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: MediaQuery.of(context).size.height * 0.035,
//                                 left: MediaQuery.of(context).size.width * 0.055,
//                                 right: MediaQuery.of(context).size.width * 0.025),
//                             child: Container(
//                               height: MediaQuery.of(context).size.height * 0.08,
//                               width: MediaQuery.of(context).size.width - 80,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: const Color(0xFF1D1D1D).withOpacity(0.12),
//                               ),
//                               child: TextFormField(
//                                 controller: _phoneController,
//                                 keyboardType: TextInputType.number,
//                                 cursorColor:  Get.isDarkMode ? Colors.white : Colors.black,
//                                 showCursor: true,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Enter your number',
//                                   hintStyle: const TextStyle(
//                                     fontSize: 17,
//                                     color: Color(0xFF455A64),
//                                   ),
//                                   contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
//                                   prefixIcon: Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//                                     child: Text('(+234)',
//                                     style: TextStyle(
//                                       color: const Color(0xFF2B3849).withOpacity(0.9),
//                                       fontSize: 17
//                                     ),
//                                     ),
//                                   ),
//                                     suffixIcon: InkWell(
//                                       onTap: wait?null: (){
//                                         startTimer();
//                                         setState(() {
//                                           start= 60;
//                                           wait= true;
//                                           buttonName = 'resend';
//                                         });
//                                         verifyPhoneNumber('+234${_phoneController.text}',
//                                             context, setData);
//                                       },
//                                       child: Padding(
//                                       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                                       child: Text(
//                                         buttonName,
//                                       style: TextStyle(
//                                         color:  wait? Colors.black54 : const Color(0xFF2B3849),
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       ),
//                                   ),
//                                     )
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width - 30,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: 1,
//                                     color: Colors.grey,
//                                     margin: const EdgeInsets.symmetric(horizontal: 14),
//                                   ),
//                                 ),
//                                 const Text('Enter 6 Digit OTP',
//                                 style: TextStyle(
//                                   color: Color(0xFF2B3849), fontSize: 17
//                                 ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     height: 1,
//                                     color: Colors.grey,
//                                     margin: const EdgeInsets.symmetric(horizontal: 14),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: otpField(),
//                           ),
//                           SizedBox(height: MediaQuery.of(context).size.height * 0.035),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: RichText(
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: 'Send OTP again in',
//                                       style: TextStyle(color:  Get.isDarkMode ? Colors.white : Colors.black87,
//                                       fontSize: 16
//                                       )),
//                                     TextSpan(
//                                       text: ' 00:$start',
//                                       style: TextStyle( color: Get.isDarkMode ? Colors.white : Colors.black87,
//                                       fontSize: 16
//                                       )),
//                                     TextSpan(
//                                       text: ' sec',
//                                       style: TextStyle( color: Get.isDarkMode ? Colors.white : Colors.black87,
//                                       fontSize: 16
//                                       )),
//                                   ]
//                                 )),
//                           ),
//                            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
//                           Padding(
//                             padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.55),
//                             child: ElevatedButton(
//                                 style: ButtonStyle(
//                                     elevation: MaterialStateProperty.all<double>(
//                                       5,),
//                                     shadowColor: MaterialStateProperty.all<Color>(
//                                         Colors.grey),
//                                     backgroundColor: MaterialStateProperty.all<Color>(
//                                       const Color(0xFF5C85C1).withOpacity(0.5),)
//                                 ),
//                                 child: const Text('Sign Up',
//                                   style: TextStyle(color: Colors.white,
//                                       fontSize: 20),),
//                                 onPressed: (){
//                                   signInWithPhoneNumber(smsCode, context);
//                                 }),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
//
//   void startTimer (){
//     const onsec = Duration(seconds: 1);
//     Timer timer = Timer.periodic(onsec, (timer){
//       if (start == 0){
//         setState(() {
//           timer.cancel();
//           wait = false;
//         });
//       } else {
//         setState(() {
//           start--;
//         });
//       }
//     });
//   }
//
//   Widget otpField (){
//     return OTPTextField(
//       length: 6,
//       width: MediaQuery.of(context).size.width - 25,
//       fieldWidth: 45,
//       otpFieldStyle: OtpFieldStyle(
//         backgroundColor: const Color(0xFF1D1D1D).withOpacity(0.12),
//         borderColor: const Color(0xFF2B3849),
//       ),
//       style: const TextStyle(
//           fontSize: 18
//       ),
//       textFieldAlignment: MainAxisAlignment.spaceAround,
//       fieldStyle: FieldStyle.underline,
//       onCompleted: (pin) {
//         print("Completed: " + pin);
//         setState(() {
//           setData(smsCode = pin);
//         });
//       },
//     );
//   }
//
//   void setData(verificationId){
//     setState(() {
//       verificationIdFinal = verificationId;
//     });
//     startTimer();
//   }
//
//   Future<void>verifyPhoneNumber(String phoneNumber, BuildContext context, Function setData)
//   async {
//     verificationCompleted (credential)async{
//       await auth.signInWithCredential(credential);
//     }
//     verificationFailed(FirebaseAuthException exception){
//       showSnackBar(context, exception.toString());
//     }
//     codeSent(String verificationID, [int? forceResendingToken]){
//       showSnackBar(context, 'Verification code sent to the phone number');
//       setData(verificationID);
//     }
//     codeAutoRetrievalTimeout(String verificationID){
//       showSnackBar(context, 'Time Out');
//       setData(verificationID);
//     }
//
//     await auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//   }
//
//
//   Future<void> signInWithPhoneNumber(String smsCode, BuildContext context)async {
//     AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationIdFinal, smsCode: smsCode);
//     UserCredential userCredential = await auth.signInWithCredential(credential);
//     storeTokenAndDta(userCredential);
//     Navigator.pushAndRemoveUntil(context,
//         MaterialPageRoute(builder: (builder)=> const RootPage()), (route) => false);
//     showSnackBar(context, 'signed in');
//   }
//
//
//   void showSnackBar(BuildContext context, String text){
//     final snackBar = SnackBar(content: Text('event: $text'));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     print(text);
//   }
//
//   Future<void> storeTokenAndDta(UserCredential userCredential) async {
//     await storage.write(
//         key: 'token', value: userCredential.credential?.token.toString());
//     await storage.write(
//         key: 'userCredential', value: userCredential.toString());
//   }
// }

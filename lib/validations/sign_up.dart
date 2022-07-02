
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_me/foundation/root_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  final storage = const FlutterSecureStorage();

  Future<String?> getToken () async{
    return await storage.read(key: 'token');
  }
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
   bool _obscureText = true;
   bool _obscuredText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFEF9),
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
                      child: const Text('Create An Account',
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
                      padding: const EdgeInsets.all(25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
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
                                          width: 0.9,
                                          color: Get.isDarkMode?Colors.black:Colors.black
                                      ),
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    labelText: 'Email',
                                    labelStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF455A64),
                                    ),
                                    prefixIcon: const Icon(Icons.email_outlined,
                                      size: 17, color: Colors.black87,),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height * 0.035,
                                  left: MediaQuery.of(context).size.width * 0.025,
                                  right: MediaQuery.of(context).size.width * 0.025,),
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
                                  cursorColor: Colors.black,
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
                                          width: 0.9,
                                          color:  Get.isDarkMode?Colors.black:Colors.black
                                      ),
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF455A64),
                                    ),
                                    prefixIcon: const Icon(Icons.lock_open_rounded,
                                        size: 18, color: Colors.black87,),
                                    suffixIcon: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _obscureText =!_obscureText;
                                        });
                                      },
                                      child: Icon(_obscureText? Icons.visibility
                                          : Icons.visibility,
                                          size: 18,color: Colors.black87),
                                    ),
                                    ),
                                  ),
                                ),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height * 0.035,
                                    left:MediaQuery.of(context).size.width * 0.025,
                                    right: MediaQuery.of(context).size.width * 0.025,),
                                child: TextFormField(
                                    key: const ValueKey('password'),
                                    validator: (value){
                                      if (value!.isEmpty) {
                                        return 'Please re-enter password';
                                      }
                                      if (_passController.text != _repassController.text){
                                        return 'Password doesn\'t match ';
                                      }
                                      if (_repassController.text.length < 6){
                                        return 'Enter at least 5 characters';
                                      }
                                      return null;
                                    },
                                    controller: _repassController,
                                    showCursor: true,
                                    obscureText: _obscuredText,
                                    decoration:  InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: const Color(0xFF5C85C1).withOpacity(0.7)
                                        ),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.9,
                                            color:  Get.isDarkMode?Colors.black:Colors.black
                                        ),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      labelText: 'Confirm Password',
                                        labelStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF455A64),
                                        ),
                                      prefixIcon: const Icon(Icons.lock_open_rounded,
                                        size: 18, color: Colors.black87,),
                                      suffixIcon: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _obscuredText =!_obscuredText;
                                          });
                                        },
                                        child: Icon(_obscuredText? Icons.visibility
                                            : Icons.visibility,
                                            size: 18,color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ),
                             SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.5),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all<double>(
                                        5,),
                                      shadowColor: MaterialStateProperty.all<Color>(
                                          Colors.grey),
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        const Color(0xFF5C85C1).withOpacity(0.5),)
                                  ),
                                  child: const Text('Sign Up',
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 20),),
                                  onPressed: () async {
                                    try {
                                      if(_formKey.currentState!.validate()){
                                        UserCredential userCredential =
                                        await firebaseAuth.createUserWithEmailAndPassword(
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
    await storage.write(key: 'token', value: userCredential.credential?.token.toString());
    await storage.write(key: 'userCredential', value: userCredential.toString());
  }

}

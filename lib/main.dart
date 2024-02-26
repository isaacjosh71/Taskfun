import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:task_me/firebase_options.dart';
import 'package:task_me/foundation/notification_services.dart';
import 'package:task_me/foundation/theme_services.dart';
import 'package:task_me/foundation/themes.dart';
import 'package:task_me/foundation/root_page.dart';
import 'package:task_me/screens/splash.dart';
import 'package:task_me/validations/auth_service.dart';
import 'package:task_me/validations/log_in.dart';
import 'package:task_me/validations/sign_up.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await NotifyHelper().initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const Splash();
  AuthClass authClass = AuthClass();
  SignUp signUp = const SignUp();
  LogIn login = const LogIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogIn();
    stillCheckLogIn();
    stillCheckLoggIn();
  }

  void checkLogIn() async {
    String? token = await authClass.getToken();
    if (token != null){
      setState(() {
        currentPage = const RootPage();
      });
    }
  }

  void stillCheckLogIn() async {
    String? token = await signUp.getToken();
    if (token != null){
      setState(() {
        currentPage = const RootPage();
      });
    }
  }

  void stillCheckLoggIn() async {
    String? token = await login.getToken();
    if (token != null){
      setState(() {
        currentPage = const RootPage();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        home: currentPage,
      );
    },
    );
  }
}

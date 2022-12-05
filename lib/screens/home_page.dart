
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_me/foundation/theme_services.dart';
import 'package:task_me/foundation/themes.dart';
import 'package:task_me/screens/task_view_detail.dart';
import 'package:task_me/widgets/task_tile.dart';
import '../foundation/notification_services.dart';
import '../foundation/root_page.dart';
import '../validations/auth_service.dart';
import '../validations/log_option.dart';
import '../widgets/ads.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  DateTime _selectedDate = DateTime.now();
  dynamic notifyHelper;

  XFile? image;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    loadImage();
  }

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static AuthClass authClass = AuthClass();
   Stream<QuerySnapshot<Object>> diffUserStream =
   FirebaseFirestore.instance.collection('TaskFun').doc(auth.currentUser!.uid).collection('UserData').snapshots();

  final ImagePicker _picker = ImagePicker();

  String? _imagePath;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: GestureDetector(
              onTap: () async {
                image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  image = image;
                });
                _saveImage(image!.path);
              },
              child: _imagePath!= null?CircleAvatar(
                backgroundImage: FileImage(File(_imagePath!)),
                radius: 70,
              )
              : CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 70,
                backgroundImage: _getImage(),
              )
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                iconSize: 23,
                onPressed: () {
                  ThemeServices().switchTheme();
                  notifyHelper.displayNotification(
                      title: 'Theme Changed',
                      body: Get.isDarkMode
                          ? 'Activated Light Theme'
                          : 'Activated Dark Theme'
                  );
                },
                icon: Icon(Get.isDarkMode ? Icons.wb_sunny_rounded : Icons
                    .nightlight_round,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),),
              IconButton(
                iconSize: 23,
                onPressed: () async {
                  authClass.logOut;
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (builder) => const LogOption()), (
                      route) => false);
                },
                icon: Icon(Icons.logout,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),),
            ],
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 7),
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery
              .of(context)
              .size
              .width * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Ads(),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.010,
              ),
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text('Today',
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02,
              ),
              DatePicker(
                DateTime.now(),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.13,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.18,
                initialSelectedDate: DateTime.now(),
                selectionColor: const Color(0xFF5C85C1).withOpacity(0.8),
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Get.isDarkMode ? Colors.grey.shade100 : Colors.grey
                        .shade900,
                  ),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey
                        .shade600,
                  ),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey
                        .shade600,
                  ),
                ),
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.03,
              ),
              const Text('My Tasks',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),),
              StreamBuilder(
                stream: diffUserStream,
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Card(
                      elevation: 0,
                      color: context.theme.backgroundColor,
                      child: Center(
                        child: Text('Loading...',
                          style: subHeadingStyle,),
                      ),
                    );
                  }
                  return Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            Color tileColor = const Color(0xFF5C85C1)
                                .withOpacity(0.8);
                            Map<String, dynamic> document = snapshot.data
                                .docs[index].data() as Map<String, dynamic>;
                            switch (document['Color']) {
                              case 0:
                                tileColor = Colors.pink.shade300;
                                break;
                              case 1:
                                tileColor = Colors.deepPurpleAccent;
                                break;
                              case 2:
                                tileColor = Colors.blue;
                                break;
                              case 3:
                                tileColor = Colors.teal.shade300;
                                break;
                              case 4:
                                tileColor = Colors.orangeAccent.shade200;
                                break;
                              default:
                                tileColor =
                                    const Color(0xFF5C85C1).withOpacity(0.8);
                            }
                            if (document['Repeat'] == 'Daily') {
                              DateTime date = DateFormat.jm().parse(
                                  document['StartTime'].toString());
                              var myTime = DateFormat('HH:mm').format(date);
                              notifyHelper.scheduledNotification(
                                int.parse(myTime.toString().split(':')[0]),
                                int.parse(myTime.toString().split(':')[1]),
                                document,
                              );
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Dismissible(
                                      background: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.15,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          decoration: BoxDecoration(
                                              color: Colors.lightGreen,
                                              borderRadius: BorderRadius
                                                  .circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Icon(Icons.check,
                                                  color: Get.isDarkMode ? Colors
                                                      .black : Colors.white,
                                                  size: 25,
                                                ),
                                                Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      secondaryBackground: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.15,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius
                                                  .circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(),
                                                Icon(Icons.delete,
                                                  color: Get.isDarkMode ? Colors
                                                      .black : Colors.white,
                                                  size: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        setState(() {
                                          FirebaseFirestore.instance.collection(
                                              'TaskFun')
                                              .doc(auth.currentUser!.uid).collection('UserData').
                                          doc(snapshot.data.docs[index].id).delete().
                                          then((value) =>
                                              Get.to(()=> const RootPage())
                                          );
                                        });
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(context: context,
                                              barrierColor: context.theme.backgroundColor,
                                              builder: (context) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.38),
                                                  child: AlertDialog(
                                                    backgroundColor: context.theme.backgroundColor,
                                                    content: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: TaskView(
                                                                  document: document,
                                                                  id: snapshot
                                                                      .data
                                                                      .docs[index]
                                                                      .id,
                                                                ),
                                                                type: PageTransitionType
                                                                    .fade));
                                                      },
                                                      child: Container(
                                                        color: context.theme.backgroundColor,
                                                        height: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.15,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width * 0.05,
                                                        child: Center(
                                                          child: Text(
                                                            'Edit Task',
                                                            style: titleStyle,
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(13),
                                                          color: const Color(
                                                              0xFF5C85C1)
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: TaskTile(
                                          description: document['Description'] ??
                                              'Null',
                                          title: document['Title'] ?? 'Null',
                                          startTime: document['StartTime'] ??
                                              'Null',
                                          date: document['Date'] ?? 'Null',
                                          endTime: document['EndTime'] ??
                                              'Null',
                                          color: tileColor,
                                          document: const {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (document['Date'] ==
                                DateFormat.yMd().format(_selectedDate)) {
                              DateTime date = DateFormat.jm().parse(
                                  document['StartTime'].toString());
                              var myTime = DateFormat('HH:mm').format(date);
                              notifyHelper.scheduledNotification(
                                int.parse(myTime.toString().split(':')[0]),
                                int.parse(myTime.toString().split(':')[1]),
                                document,
                              );
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Dismissible(
                                      background: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.15,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          decoration: BoxDecoration(
                                              color: Colors.lightGreen,
                                              borderRadius: BorderRadius
                                                  .circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Icon(Icons.check,
                                                  color: Get.isDarkMode ? Colors
                                                      .black : Colors.white,
                                                  size: 25,
                                                ),
                                                Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      secondaryBackground: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.15,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius
                                                  .circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(),
                                                Icon(Icons.delete,
                                                  color: Get.isDarkMode ? Colors
                                                      .black : Colors.white,
                                                  size: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        setState(() {
                                          FirebaseFirestore.instance.collection(
                                              'TaskFun')
                                              .doc(auth.currentUser!.uid).collection('UserData').
                                          doc(snapshot.data.docs[index].id).delete().
                                              then((value) =>
                                              Get.to(()=> const RootPage())
                                          );
                                        });
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.38),
                                                  child: AlertDialog(
                                                    content: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: TaskView(
                                                                  document: document,
                                                                  id: snapshot
                                                                      .data
                                                                      .docs[index]
                                                                      .id,
                                                                ),
                                                                type: PageTransitionType
                                                                    .fade));
                                                      },
                                                      child: Container(
                                                        height: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.15,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width * 0.05,
                                                        child: Center(
                                                          child: Text(
                                                            'Edit Task',
                                                            style: titleStyle,
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(13),
                                                          color: const Color(
                                                              0xFF5C85C1)
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: TaskTile(
                                          description: document['Description'] ??
                                              'Null',
                                          title: document['Title'] ?? 'Null',
                                          startTime: document['StartTime'] ??
                                              'Null',
                                          date: document['Date'] ?? 'Null',
                                          endTime: document['EndTime'] ??
                                              'Null',
                                          color: tileColor,
                                          document: const {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getImage() {
    final image = this.image;
    if (image != null) {
      return FileImage(File(image.path));
    }
    return const AssetImage('assets/images/profile.png');
  }

  void _saveImage (path) async{
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString('imagePath', path);
  }

  void loadImage() async{
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState((){
      _imagePath = saveImage.getString('imagePath');
    });
  }
}


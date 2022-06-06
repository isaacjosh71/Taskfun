
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_me/screens/add_task.dart';
import 'package:task_me/screens/home_page.dart';



class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}


class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              PageTransition(
                  alignment: Alignment.bottomRight,
                  child: const AddTask(),
                  type: PageTransitionType.scale));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        backgroundColor: const Color(0xFF5C85C1).withOpacity(0.9),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: const HomePage(),
    );
  }
}


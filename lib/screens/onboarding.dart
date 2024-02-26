
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_me/model/contents.dart';
import 'package:flutter/material.dart';
import 'package:task_me/validations/sign_option.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        minimum:  EdgeInsets.only(top:
        MediaQuery.of(context).size.height * 0.07),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:  PageView.builder(
                  controller: _controller,
                  onPageChanged: (int index){
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  scrollBehavior: const ScrollBehavior(
                    androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
                  ),
                  itemCount: contents.length,
                  itemBuilder: (_,i){
                    return Padding(padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Image.asset(
                                contents[i].image,
                                height: MediaQuery.of(context).size.height * 0.3
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01),
                            Text(
                              contents[i].text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF2B3849),
                                fontSize:24,
                              ),),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02
                            ),
                            Text(
                              contents[i].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Get.isDarkMode ? Colors.white70 :  Colors.black54,
                                fontSize: 15,
                                  fontFamily: 'Roboto'
                              ),),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.07
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              List.generate(contents.length, (index){
                                return buildDot(index, context);
                              }),
                            ),
                          ],
                        ),
                      );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
              child: GestureDetector(
                onTap: () {
                  if (currentIndex == contents.length - 1){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: (context)=>const SignOption()
                        ));
                  }
                  _controller.nextPage(duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: currentIndex == contents.length -1
                      ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF5C85C1).withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(currentIndex == contents.length -1
                          ? 'Get Started' : 'Next',
                        style: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                            fontSize: 17),),
                      const Icon(Icons.navigate_next_sharp),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.09),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(duration: const Duration(milliseconds: 300),
      height: 6.0,
      width: currentIndex == index ? 18:8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF5C85C1).withOpacity(0.5)
      ),
    );
  }
}
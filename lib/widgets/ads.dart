
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Ads extends StatelessWidget {
  const Ads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
              child: Card(
                color: const Color(0xFF5C85C1).withOpacity(0.8),
                elevation: 5,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      bottomLeft: Radius.circular(23),
                      bottomRight: Radius.circular(28),
                    ),
                    side: BorderSide.none
                ),
                child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(7),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star,
                        color: Colors.white,
                        size: 15,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Taskfun',
                                textAlign: TextAlign.justify,
                                textStyle: const TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                )),],
                          repeatForever: true,
                          pause: const Duration(seconds: 60),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text('Create and stay updated with your tasks',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),),
                      ],
                    )
                  ],
                ),
          ),
              ),
            ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:task_me/foundation/themes.dart';
import 'package:get/get.dart';

class InputForm extends StatelessWidget {
 final String title;
 final dynamic hint;
 final TextEditingController? controller;
 final Widget? widget;

  const InputForm({Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.widget, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
          style: titleStyle),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Row(
            children: [
              Expanded(child:
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.028,
                    ),
                    child: TextFormField(
                      readOnly: widget==null?false:true,
                      autofocus: false,
                      controller: controller,
                      style: subHeadingStyle,
                      cursorColor: Get.isDarkMode? Colors.grey[100]:Colors.grey[400],
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subHeadingStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: context.theme.backgroundColor
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                            color: const Color(0xFF5C85C1).withOpacity(0.7),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: widget
                      ),
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

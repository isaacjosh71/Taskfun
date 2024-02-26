
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../foundation/root_page.dart';
import 'package:intl/intl.dart';
import 'package:task_me/foundation/themes.dart';
import 'package:task_me/widgets/input_form.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime =  const TimeOfDay(hour: 12, minute: 00);
  TimeOfDay _endTime =  const TimeOfDay(hour: 12, minute: 00);
  String _selectedRepeat = 'None';
  List<String> repeatList= [
    'None', 'Daily', 'Weekly', 'Monthly'
  ];
  int _selectedColor = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final hours = _startTime.hour.toString().padLeft(2, '0');
    final minutes = _startTime.minute.toString().padLeft(2, '0');
    final endHours = _endTime.hour.toString().padLeft(2, '0');
    final endMinutes = _endTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading:
        IconButton(
          iconSize: 23,
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(
                builder: (builder)=> const RootPage()));
          },
          icon: Icon(Icons.arrow_back,
            color: Get.isDarkMode? Colors.white: Colors.black,
          ),),
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
          child: Text('Add Task', style: TextStyle(color: Get.isDarkMode? Colors.white: Colors.black),),
        ),
        titleTextStyle: headingStyle,
    ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                InputForm(title: 'Title',
                    hint: 'Enter your task title',

                    controller: _titleController,
                    widget: null,),
                InputForm(title: 'Description',
                  hint: 'Enter your task description',
                  controller: _descriptionController,
                  widget: null,),
                InputForm(title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(onPressed: () async {
                    DateTime? _pickerDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2121));
                    if (_pickerDate!=null){
                      setState((){
                        _selectedDate = _pickerDate;
                      });
                    }else {
                          (e){
                        final snackBar = SnackBar(content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      };
                    }
                  },
                      icon: const Icon(Icons.calendar_today_outlined,
                        color: Colors.grey,)),
                  controller: null,),
                Row(
                  children: [
                    Expanded(
                        child: InputForm(
                          controller: null,
                          title: 'Start Time',
                          hint: '$hours:$minutes',
                          widget: IconButton(
                            onPressed: () async{
                             TimeOfDay? newStartTime = await showTimePicker(
                                  context: context,
                                  initialTime: _startTime);
                             if (newStartTime == null) return;
                             setState((){
                               _startTime = newStartTime;
                             });
                            },
                            icon: const Icon(Icons.access_alarm_outlined,
                              color: Colors.grey,
                              size: 20,),
                          ),
                        )
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Expanded(
                        child: InputForm(
                          controller: null,
                          title: 'End Time',
                          hint: '$endHours:$endMinutes',
                          widget: IconButton(
                            onPressed: () async{
                              TimeOfDay? newEndTime = await showTimePicker(
                                  context: context,
                                  initialTime: _endTime);
                              if (newEndTime == null) return;
                              setState((){
                                _endTime = newEndTime;
                              });
                            },
                            icon: const Icon(Icons.access_alarm_outlined,
                              color: Colors.grey,
                              size: 20,),
                          ),
                        )
                    ),
                  ],
                ),
                // InputForm(
                //     title: 'Reminder',
                //     hint: '$_selectedReminder minutes early',
                //     controller: null,
                //     widget: DropdownButton(
                //       onChanged: (String? newValue){
                //         setState((){
                //           _selectedReminder = int.parse(newValue!);
                //         });
                //       },
                //       icon: const Icon(Icons.keyboard_arrow_down_sharp,
                //       color:  Colors.grey,
                //       size: 33,),
                //         elevation: 4,
                //         style: subHeadingStyle,
                //         underline: Container(height: 0,),
                //         items: remindList.map<DropdownMenuItem<String>>((int value){
                //           return DropdownMenuItem<String>(
                //               value: value.toString(),
                //               child: Text(value.toString()));
                //         }).toList(),
                //         ),),
                InputForm(
                    title: 'Repeat',
                    hint: "$_selectedRepeat",
                    controller: null,
                    widget: DropdownButton(
                      onChanged: (String? newValue){
                        setState((){
                          _selectedRepeat = newValue!;
                        });
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_sharp,
                      color:  Colors.grey,
                      size: 33,),
                        elevation: 4,
                        style: subHeadingStyle,
                        underline: Container(height: 0,),
                        items: repeatList.map<DropdownMenuItem<String>>((String? value){
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value!, style: const TextStyle(color: Colors.grey),));
                        }).toList(),
                        ),),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Color',
                        style: titleStyle),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.006,
                        ),
                        Wrap(
                          children: List<Widget>.generate(5,
                                  (int index) =>  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState((){
                                          _selectedColor = index;
                                        });
                                      },
                                      child: CircleAvatar(
                                        child:_selectedColor==index?const Icon(Icons.done,
                                        size: 16,
                                        color: Colors.white,):Container(),
                                        backgroundColor: index==0?Colors.pink.shade300:
                                        index==1? Colors.deepPurpleAccent :index==2? Colors.blueAccent
                                        :index==3? Colors.teal.shade300 :Colors.orangeAccent,
                                        radius: 13,
                                      ),
                                    ),
                                  )),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        _validateData();
                      },
                      child: Card(
                        elevation: 3,
                        color: const Color(0xFF5C85C1).withOpacity(0.7),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: const Center(
                            child: Text('Create Task',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _validateData() async{
    if(_titleController.text.isNotEmpty&&_descriptionController.text.isNotEmpty){
      FirebaseFirestore.instance.collection('TaskFun').doc(auth.currentUser!.uid).collection('UserData').add(
        {'Title':_titleController.text,
          'Description':_descriptionController.text,
          'Date':DateFormat.yMd().format(_selectedDate),
          'StartTime':_startTime.format(context),
          'EndTime':_endTime.format(context),
          'Repeat':_selectedRepeat,
          'Color':_selectedColor,
        }
      );
      Get.back();
    }else if(_titleController.text.isEmpty || _descriptionController.text.isEmpty){
      Get.snackbar('Required', 'All fields are required!',
      snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.warning_amber_rounded)
      );

    }

    }
  }


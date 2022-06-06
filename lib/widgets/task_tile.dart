
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({Key? key, required this.title, required this.description,
    required this.startTime, required this.endTime, required this.date,
    required this.color, required this.document,}) : super(key: key);
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final String date;
  final Color color;
  final Map<String, dynamic> document;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 11, top: 12),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 1,
          color: widget.color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold,
                          color: Colors.white
                        )
                      ),
                      ),
                      const SizedBox(height: 7,),
                      Row(
                        children: [
                          Icon(Icons.access_alarm_outlined,
                          color: Colors.grey.shade200,
                          size: 17,),
                          const SizedBox(width: 3,),
                          Text('${widget.startTime} - ${widget.endTime}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 12, color: Colors.grey[100]
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Icon(Icons.calendar_today_outlined,
                            color: Colors.grey.shade200,
                            size: 17,),
                          const SizedBox(width: 3,),
                          Text(widget.date,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 12, color: Colors.grey[100]
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7,),
                      Text(widget.description,
                        maxLines: 2,
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300,
                                color: Colors.white
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

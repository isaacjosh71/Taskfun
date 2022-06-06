
class Tasks{
  int? id;
  String? title;
  String? description;
  String? startTime;
  String? endTime;
  String? date;
  String? repeat;
  int? remind;
  int? color;
  int? isCompleted;

  Tasks({
    this.id,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.date,
    this.repeat,
    this.remind,
    this.color,
    this.isCompleted,
});

  Tasks.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    repeat = json['repeat'];
    remind = json['remind'];
    color = json['color'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic>data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['date'] = date;
    data['repeat'] = repeat;
    data['remind'] = remind;
    data['color'] = color;
    data['isCompleted'] = isCompleted;
    return data;

  }
}